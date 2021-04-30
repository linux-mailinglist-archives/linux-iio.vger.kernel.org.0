Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069D43702F1
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 23:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhD3VY6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 17:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhD3VY6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Apr 2021 17:24:58 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B57C06174A;
        Fri, 30 Apr 2021 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t45yD8Tz8EVh7zr7z9a7QSK1nAjvYCl7n2zVHHXnLGk=; b=POTbr6zXE1kikSsUIgDM8jOS6M
        1ncmQva3gUCk3tr70PK7l/PoctVdgJoqPAuAegB9ijO3CeHgv+x6L/WSA/F5IinFFx/s5cRPljODp
        I9IKK0easSJsomyru6Di3XjhC9JAgwkE1o3egl9j4jHIUiDUb7BuZH3AQGtEBqHHH0nM=;
Received: from p200300ccff0893001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:9300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lcacH-0003hy-C6; Fri, 30 Apr 2021 23:24:05 +0200
Date:   Fri, 30 Apr 2021 23:24:04 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        linux-hwmon@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        kernel@pengutronix.de, linux-imx@nxp.com
Cc:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        letux-kernel@goldelico.com
Subject: [Q] tps65185 EPD PMIC temperature interface - which subsystem
Message-ID: <20210430232404.26d60fef@aktux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I am going about to clean up stuff to further upstream support for my
ebook readers. One question arises about the temperature interface of
the EPD PMIC. Vendor code uses regulator_get_voltage in the EPDC
driver to read a temperature in celsius and provides temperature through
the regulator interface (besides sysfs/hwmon). That is ugly. But what
are the options, if a kernel consumer should be able to reference it via
devicetree phandle and read out from it? I see temperature sensors
both in the iio and the hwmon subsystem, but do not find a description
why these things are there. If I put it into the iio-subsystem
iio_channel_get() and friends can be used, if I understand things
correctly, there are no such functions in the hwmon subsystem, so I
would not be able to use it there. So the better choice is to put it
into the iio subsystem?

On the consumer side, the temperature, which is pratically the ambient
temperature, is used to choose the right waveform for the corresponding
temperature range. Here are some code snippets in the vendor kernel:

temperature = regulator_get_voltage(fb_data->tmst_regulator);
dev_dbg(fb_data->dev, "auto temperature reading = %d\n", temperature);

if (temperature != 0xFF) {
	fb_data->last_time_temp_auto_update = now;
	fb_data->temp_index = mxc_epdc_fb_get_temp_index(fb_data, temperature);
}

static int mxc_epdc_fb_get_temp_index(struct mxc_epdc_fb_data *fb_data, int temp
)
{
        int i;
        int index = -1;

        if (fb_data->trt_entries == 0) {
                dev_err(fb_data->dev,
                        "No TRT exists...using default temp index\n");
                return DEFAULT_TEMP_INDEX;
        }

        /* Search temperature ranges for a match */
        for (i = 0; i < fb_data->trt_entries - 1; i++) {
                if ((temp >= fb_data->temp_range_bounds[i])
                        && (temp < fb_data->temp_range_bounds[i+1])) {
                        index = i;
                        break;
                }
        }

... and writing that index to some register in the EPDC.

As the consumer is not upstream (I have a basic drm-based variant also
in my clean-up queue), compatibilty to existing systems does not matter
that much. Also I see no drivers for similar chips upstream.

Regards,
Andreas
