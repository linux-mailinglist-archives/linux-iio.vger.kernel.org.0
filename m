Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2048692BEA
	for <lists+linux-iio@lfdr.de>; Sat, 11 Feb 2023 01:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBKAZi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Feb 2023 19:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKAZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2023 19:25:38 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA897BFEC
        for <linux-iio@vger.kernel.org>; Fri, 10 Feb 2023 16:25:36 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so4888788pgh.4
        for <linux-iio@vger.kernel.org>; Fri, 10 Feb 2023 16:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676075136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VtnqhavMyOvZQPtQTex9KD7FvqZIlAAiIw/rBW5ddZU=;
        b=KcuKx5bgm2jEMonR2R7TWafmGsaQ7L+edAh09gV1vGrHPAflGOm5WX2A9j+epkR15j
         d2mGR9E/EHeYaxPmc43qRFVzTrGGMkqzbwcc8LmTeeYIOWVVrGSkgfWZ2w7mtSJe2tMH
         NXJ7PF2AdRF7JU+SGdRMKEOeN1xexdqkVlNgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676075136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtnqhavMyOvZQPtQTex9KD7FvqZIlAAiIw/rBW5ddZU=;
        b=AGEIY8eqaJGpNDoevkRSBR73CayLZNkyruzIoMt2tRcdWM0HBq/8KVJqvLaYxulsl0
         4zXXgX7WXd27hOUYU8+9QUCIPwkBGzXtlfTOUsPUHUsXBvdMBT/uBUBGVZ7b/DNSAyTN
         Cn2udNHigyy7V2pl7aqBbP0PFMkWzfYagJGUSYg27pq+P+QasHPynZoI708AwO9iorCX
         x5D2q1oXwYHq5gmzff7Rjk3YljICp0BqZ3IPE1VzuUPg+22PYc6Vs7F4+S3Pcxj5Twq2
         JVWq2V1muv+0cXUnPCjPxRrfj76eY89p7bgdsFX95dporp2cbQ3uhmA3U+GNcP8+hazY
         p44g==
X-Gm-Message-State: AO0yUKUMR6x4dxTLAw9LOn6t9HWCy0Iy+VGafF/J1Z+Wlgdc76RQ2Bc0
        nOS8NCXoBU5KfZOuCUfMx/CKRpcGhI5aRksnB21bX989BW189nxU
X-Google-Smtp-Source: AK7set8WUWKg8UvUM/yp/EBUZEutpYURzxVkP/V/NwRvJWwkxthCgTqFApMgI1yRwoqMuvHWG95CCTCUwDfCj9TB/B8=
X-Received: by 2002:a62:2903:0:b0:59d:553e:c81 with SMTP id
 p3-20020a622903000000b0059d553e0c81mr3256334pfp.51.1676075136318; Fri, 10 Feb
 2023 16:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20230129003753.1980309-1-gwendal@chromium.org>
 <CAE-0n510nBDOdWXH43qhRtVsQOCPCbkeP1wCr2LvGXbbXyg5yg@mail.gmail.com>
 <20230205145759.2ce9f274@jic23-huawei> <20230210171720.30ef1be9@jic23-huawei>
In-Reply-To: <20230210171720.30ef1be9@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 10 Feb 2023 16:25:23 -0800
Message-ID: <CAPUE2usxwfKBCSN8DAaZDZvjL+_5tXQBR2U40eY6i02_7HGWsA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: proximity: sx_common: Add old register mapping
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 10, 2023 at 9:03 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 5 Feb 2023 14:57:59 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Mon, 30 Jan 2023 11:41:31 -0800
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > > Quoting Gwendal Grignou (2023-01-28 16:37:53)
> > > > Older firmwares still send sensor configuration using a list of
> > > > registers with opaque values defined during sensor tuning.
> > > > sx9234 and sx9360 sensor on ACPI based devices are concerned.
> > > > More schema to configure the sensors will be needed to support devices
> > > > designed for windows, like Samsung Galaxy Book2.
> > > >
> > > > Support schema is: "<_HID>.<register_name>". For instance
> > > > "STH9324,reg_adv_ctrl2" in:
> > > >
> > > >     Scope (\_SB.PCI0.I2C2)
> > > >     {
> > > >         Device (SX28)
> > > >         {
> > > >             Name (_HID, "STH9324")  // _HID: Hardware ID
> > > > ...
> > > >             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
> > > >             {
> > > >                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /*
> > > > Device Properties for _DSD */,
> > > >                 Package (0x3F)
> > > >                 {
> > > > ...
> > > >                     Package (0x02)
> > > >                     {
> > > >                         "STH9324,reg_adv_ctrl2",
> > > >                         Zero
> > > >                     },`
> > > >
> > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > > ---
> > >
> > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Applied to the togreg branch of iio.git and pushed out as testing.
> >
> > Timing wise, we are late in the cycle so this might not make it upstream
> > until next cycle.
> >
>
> Dropped for now as we need to fix an issue with acpi_device_hid()
> not being defined with !CONFIG_ACPI that broke some builds in next.
Fixed in v4 by using #ifdef CONFIG_ACPI in sx_common_get_raw_register_config().
Thanks,
Gwendal.
>
> Jonathan
>
>
> > Thanks,
> >
> > Jonathan
> >
>
