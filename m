Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B88285610
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 03:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgJGBMz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 21:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJGBMy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 21:12:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F2C061755;
        Tue,  6 Oct 2020 18:12:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so213522pjb.5;
        Tue, 06 Oct 2020 18:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mhoMukFtXUDnoxYBeSc1gCnHDJjh2RBWkCrpacxBvgc=;
        b=BZ5McIJk7M9QpLpb5KoCQkdxJYiPrNQhgs5cl4vLLWytK5VF9kyh4DJe1g7PqgOdHJ
         vi9SNcnbS6RVeKxhRm1gfXYW/1MobIU3emLb+keannjof0F62HLir3wvH+3R+JnKfDDw
         hUuIq3r2W7hYuJwomu2PHIw9cHJh2bCarSSmPf2vcxlwhVYPy1B59pQCZh88VJfxM+SH
         P3U1OKhTrqq3QQBPtMpZx/3RzdSMWOBjkBQktmI99bmH+2SMTqoB4KKC16f0DxyVah5V
         LrrH+r9brZLGlfmZ2vd2w1S9l0EWtUIDgohzA1Ws4rcazlyeai7Bzg+4oBQf9+qgFD1f
         D10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mhoMukFtXUDnoxYBeSc1gCnHDJjh2RBWkCrpacxBvgc=;
        b=tS0Ml+Y0Dw5j/SRwEKUylvVONA0aagIP22QfpHoSXqFa8exJjA/tqhzLKB8yU9wct1
         uYocjmb0NrgxGzIt5B6ymksQzt9M2YT22LUJ6MzZK8tUzE4xexOiWtDKgoHbgs/ImV2c
         cuLiB0qoM/e6mLec82qEARigL5Q/t8om6XLMgYdSd79Uho4bKKt4GPgivgY01YypHxHq
         20W3bNbKPla4VKtYgu3D1MYMFG50Ktg5G9aHRPCaX015QBvwdGFA0RMftu0ldlkTIrTU
         sGh2imjbHZL5r0TwHXglLQGqWc2001aPQuMamSb0ZeF4c/YVtXb6n8KQj1BQPKjsGpsb
         BsBQ==
X-Gm-Message-State: AOAM533lTQL+SB9+qiMJ8Rlk6VQ2zDJElYD9jHKylAvSU3yedmxTbAjP
        8oKY4HvzTy7UsrJ9vtOxzek=
X-Google-Smtp-Source: ABdhPJy4dLisQACUERV0GxDAYvpdj82oBH4eI0zaGWCX8W7avrgYWVStQLex6A0apJQoB8lnZYPvuA==
X-Received: by 2002:a17:90a:1a02:: with SMTP id 2mr708050pjk.201.1602033174099;
        Tue, 06 Oct 2020 18:12:54 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id f17sm412371pgd.86.2020.10.06.18.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 18:12:53 -0700 (PDT)
Date:   Tue, 6 Oct 2020 18:12:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Patrik Fimml <patrikf@chromium.org>
Subject: Re: [PATCH v4 7/7] Input: Add "inhibited" property
Message-ID: <20201007011249.GS1009802@dtor-ws>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-8-andrzej.p@collabora.com>
 <20201005181014.GL1009802@dtor-ws>
 <ac4eeab7-8333-b96b-707b-eb2d6d0d8139@collabora.com>
 <20201007011102.GR1009802@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007011102.GR1009802@dtor-ws>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 06, 2020 at 06:11:02PM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 06, 2020 at 03:04:28PM +0200, Andrzej Pietrasiewicz wrote:
> > Hi Dmitry,
> > 
> > W dniu 05.10.2020 o 20:10, Dmitry Torokhov pisze:
> > > Hi Andrzej,
> > > 
> > > On Mon, Jun 08, 2020 at 01:22:11PM +0200, Andrzej Pietrasiewicz wrote:
> > > > @@ -284,8 +284,11 @@ static int input_get_disposition(struct input_dev *dev,
> > > >   	case EV_KEY:
> > > >   		if (is_event_supported(code, dev->keybit, KEY_MAX)) {
> > > > -			/* auto-repeat bypasses state updates */
> > > > -			if (value == 2) {
> > > > +			/*
> > > > +			 * auto-repeat bypasses state updates but repeat
> > > > +			 * events are ignored if the key is not pressed
> > > > +			 */
> > > > +			if (value == 2 && test_bit(code, dev->key)) {
> > > >   				disposition = INPUT_PASS_TO_HANDLERS;
> > > >   				break;
> > > >   			}
> > > 
> > > Is this chunk really part of inhibit support? I'd think we cancel
> > > autorepeat timer when we are releasing a key, no?
> > > 
> > 
> > When I look at it now it seems to me the chunk might be redundant.
> > But let me explain what I had in mind when adding it.
> > 
> > It is a matter of what we do with input events generated while a
> > device is inhibited. If ->open()/->close() are not provided by the
> > driver then inhibiting amounts to merely ignoring input events from
> > a device while it remains active. What else can you do if the driver
> > does not provide a method to prepare the device for generating events/
> > to stop generating events?
> > 
> > In this special case a user might trigger a repeated event while the
> > device is inhibited, then the user keeps holding the key down and the
> > device is uninhibited. Do we pass anything to handlers then?
> > 
> > In my opinion we should not. Such an event is "illegal" in a sense that it
> > was generated at a time when nobody wanted any events from the device.
> > Hence the test to let only those auto-repeat events through for which
> > a key is actually pressed.
> > 
> > However, what I see now is that if a device is inhibited, no key
> > will ever reach neither the "1" nor "2" state because of the "if"
> > in the very beginning of input_handle_event().
> 
> OK, then let's drop it for now. We can revisit if we see that a problem.

And by that I mean that I will drop it myself, no need to resend. I will
be applying this shortly.

Thanks.

-- 
Dmitry
