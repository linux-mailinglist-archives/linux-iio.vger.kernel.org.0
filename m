Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D57632BA9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Nov 2022 19:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiKUSAI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Nov 2022 13:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiKUR7l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Nov 2022 12:59:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A410D92FF
        for <linux-iio@vger.kernel.org>; Mon, 21 Nov 2022 09:59:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC5C4B812A1
        for <linux-iio@vger.kernel.org>; Mon, 21 Nov 2022 17:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130BBC433C1;
        Mon, 21 Nov 2022 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669053546;
        bh=PE5ZpKUvvAfk6T6aCoJPOImQjDWMlRIlKlFmL/uaJ5c=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HmL4S1GOpDcnoERShBS94urOof6CROVAzkGnwm9rOeE++uobzUYwfmPAQiFINmiBH
         YzG+4irmGJjCWSBWwh26zcHBqFvfnGVkMOMzOMxJWNvuMfL+WrXVEI3iG2znELlevc
         +trh+jY27YLwgG08SHiHBV+VeCri+UtkM2q21HldIVeTDQxHELVBeFO8ovIqf/lS0N
         4w7gDrexrGOirS3/zdrrhIZNhlOZJHU7sQMYs/CH+Ax0TShHo0OPTorzG3oehov3X2
         9T6dkIy7l8Y1ckqs9cxTwDTsb+opuTRr44mJyoXprX35ylDLZk09B4JoORPw+8ahC6
         bOOh9ZcwZCbug==
Date:   Mon, 21 Nov 2022 18:59:04 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/4] IIO: hid-sensor-als: Use generic usage
In-Reply-To: <499ca4a6bbebb458a1132e36462f97121ccb96d3.camel@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2211211858160.6045@cbobk.fhfr.pm>
References: <20221117150508.00002704@Huawei.com>  <20221117234824.6227-1-p.jungkamp@gmx.net>  <20221117234824.6227-3-p.jungkamp@gmx.net> <499ca4a6bbebb458a1132e36462f97121ccb96d3.camel@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Nov 2022, srinivas pandruvada wrote:

> > Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_ALS to
> > allow this driver to drive the Lenovo custom ambient light sensor,
> > which is registered under a 'custom' usage and not
> > HID_USAGE_SENSOR_ALS.
> > 
> > Add the Lenovo Intelligent Sensing Solution (LISS) ambient light sensor
> > to the platform device ids.
> > 
> > Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Is my understanding correct that this Ack is valid for patches 1,2 and 3 
(and not for 4) from the series?

Thanks,

-- 
Jiri Kosina
SUSE Labs

