Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85C861EC65
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 08:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiKGHsA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 02:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKGHr6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 02:47:58 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4931274E
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 23:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1667807277;
  x=1699343277;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=qBYeor+8RNRtco5N3xqieoVdgaKoez1i7B4m8GPOG/k=;
  b=Pqt628x3Halpvj7nvkC0x3LWlorFYPlR7+vRy+R2wrPIVN+rK+P22Xa7
   Kt/NWBQPTDNVmI+TvGg3GfKfeJ8CQ/qVE5JdWF9x0teY6/tIUOqlnmTbn
   Q1YtYbeMY96jyMkyc4FFKiQU698/0uHBmQj9RGpoSOljuv2dAv76q8OCZ
   HJ07siDFg6JTmPGmq8vpVM4h4zDqD+/RFldQxHjWka+LXuIox8+CkxiQj
   C8ICy6jyCx7eT46uJNvp3x6F9mzZudPnBeCFny0fPuRCB0/PRYug601oZ
   BFz1d8LjS7lRD7urzMgUSvpZIHxKI4/qfd0/PGm+telmrLyw02eIbnp5G
   Q==;
Date:   Mon, 7 Nov 2022 08:47:54 +0100
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>,
        =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>
Subject: Re: [PATCH v3 0/2] Add ps_it attributes for vcnl4040
Message-ID: <Y2i4KmJ0Bd+WdWay@axis.com>
References: <20220926091900.1724105-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926091900.1724105-1-marten.lindahl@axis.com>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 26, 2022 at 11:18:58AM +0200, Mårten Lindahl wrote:
> Currently there is no way for userspace to make any configuration of
> the VCNL4040 sensors, but only the sensor readings are exported in
> sysfs. To support configuration for proximity integration time value,
> sysfs attributes for this needs to be exported.
> 
> To begin with the runtime power management turns both sensors (ALS, and
> PS) on before reading the sensor register values and then switches
> them off again. But when doing so it writes the whole register instead
> of just switching the power on/off bit. This needs to be fixed in order
> to make other persistent configurations.
> 
> Kind regards
> Mårten Lindahl

Hi!

I suspect this mail may have slipped through unnoticed since there has
not been any comments on it. v2 had some minor comments which I hope I
fixed.

Jonathan?

Kind regards
Mårten

> 
> Changes in v3:
>  - Rename defines for ALS/PS shutdown bits
>  - Add local variable for building register value
> 
> Changes in v2:
>  - Removed unnecessary switch for chip id
>  - Guard read/write sequence against potential race
>  - Remove confusing boolean operation
>  - Use bitmask macros instead of local field shifting
>  - Use .read_avail callback instead of using IIO_CONST_ATTR
>  - Skip [PATCH 2/3] iio: light: vcnl4000: Add enable attributes for vcnl4040
> 
> Mårten Lindahl (2):
>   iio: light: vcnl4000: Preserve conf bits when toggle power
>   iio: light: vcnl4000: Add ps_it attributes for vcnl4040
> 
>  drivers/iio/light/vcnl4000.c | 185 +++++++++++++++++++++++++++++++++--
>  1 file changed, 179 insertions(+), 6 deletions(-)
> 
> -- 
> 2.30.2
> 
