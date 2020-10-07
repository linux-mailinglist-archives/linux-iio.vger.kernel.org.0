Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BB4285604
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 03:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgJGBLI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 21:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgJGBLI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 21:11:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182D3C061755;
        Tue,  6 Oct 2020 18:11:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so306625pgo.13;
        Tue, 06 Oct 2020 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6fZCLYVp6vJOGJ9UOukLRU5lx5R2NISCZkWVL54zOGg=;
        b=S5qiUfGndIGUy172Th8X9wui1g/KqnJ8Yz9sLsLNl6YQAUDRK5o7EcFi+xf0zez4lU
         NIXSdgW3vrt0s+GUQUGbX7OxXqwbkWXD8m+33T0GyZeAvoW74hyWXw6rRstZY5gebvPs
         ToVQFWRd27he3+qYh1jDNPmGoO4cRbwezUjcdzkhN2PE9k4bNM8+siHYH9dVL+LVs/rA
         WtSwbSGfCrU+7r3dpVt4XalVIcZDhg5JLS/EJsSHAJVlSgJMg9IZUNRkbGA0Zqb9Gmgi
         gr9smdR0mAVR4vuPF1ehlmGsMQ1hU3sk75bTMYGwRjIzT4yKn9xchLknf4gNlQxMAG8X
         CDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6fZCLYVp6vJOGJ9UOukLRU5lx5R2NISCZkWVL54zOGg=;
        b=NRJBBL84dy/vFskQh6N+FmrHJTRmS6dXqTjv0xXUHsthQc00BMd3rR3WrpDkWQgEjd
         1Ufq/zoDW8uirqOIU0696t2XEH1FtSiP0qhIwKz9pxGjnqJ3oqej/Z0dqp4MelLxplIG
         ivUWyuPUZeyPxCcFsrQVi1JaPDmEbLkpN/Y7lU2xJD09bc7mD8a+pqFeRu7scbalTNwH
         nnLnseei7epQNamy2ZTMs1Eb24epgGOQ/yvaRPMXRox+B9QZe8CSG7B1+3qJEWbroznI
         D4hHWT8CpoNUzwgGnxmEJljVKlrtcDKXcWnu5vb2RR0Dv9Bq87pGPVN4ps9s0oi+zXWT
         +t6Q==
X-Gm-Message-State: AOAM530iixnC8ILBFNpWlamdGr104qGcGy1QJN1XHB4LmlqdID4uI00m
        6PrqSbl2ZxhS+mPZQHMM8F4=
X-Google-Smtp-Source: ABdhPJyFRAe5gj4f3wME1Oj9xM2fApavjlXPSPwqMqBxecHV3dRBe4ft3JSqvU8nMvLBeX2kdb6ivA==
X-Received: by 2002:aa7:94a4:0:b029:151:d786:d5c2 with SMTP id a4-20020aa794a40000b0290151d786d5c2mr737596pfl.50.1602033067539;
        Tue, 06 Oct 2020 18:11:07 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id w187sm453006pfb.93.2020.10.06.18.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 18:11:06 -0700 (PDT)
Date:   Tue, 6 Oct 2020 18:11:02 -0700
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
Message-ID: <20201007011102.GR1009802@dtor-ws>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-8-andrzej.p@collabora.com>
 <20201005181014.GL1009802@dtor-ws>
 <ac4eeab7-8333-b96b-707b-eb2d6d0d8139@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac4eeab7-8333-b96b-707b-eb2d6d0d8139@collabora.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 06, 2020 at 03:04:28PM +0200, Andrzej Pietrasiewicz wrote:
> Hi Dmitry,
> 
> W dniu 05.10.2020 o 20:10, Dmitry Torokhov pisze:
> > Hi Andrzej,
> > 
> > On Mon, Jun 08, 2020 at 01:22:11PM +0200, Andrzej Pietrasiewicz wrote:
> > > @@ -284,8 +284,11 @@ static int input_get_disposition(struct input_dev *dev,
> > >   	case EV_KEY:
> > >   		if (is_event_supported(code, dev->keybit, KEY_MAX)) {
> > > -			/* auto-repeat bypasses state updates */
> > > -			if (value == 2) {
> > > +			/*
> > > +			 * auto-repeat bypasses state updates but repeat
> > > +			 * events are ignored if the key is not pressed
> > > +			 */
> > > +			if (value == 2 && test_bit(code, dev->key)) {
> > >   				disposition = INPUT_PASS_TO_HANDLERS;
> > >   				break;
> > >   			}
> > 
> > Is this chunk really part of inhibit support? I'd think we cancel
> > autorepeat timer when we are releasing a key, no?
> > 
> 
> When I look at it now it seems to me the chunk might be redundant.
> But let me explain what I had in mind when adding it.
> 
> It is a matter of what we do with input events generated while a
> device is inhibited. If ->open()/->close() are not provided by the
> driver then inhibiting amounts to merely ignoring input events from
> a device while it remains active. What else can you do if the driver
> does not provide a method to prepare the device for generating events/
> to stop generating events?
> 
> In this special case a user might trigger a repeated event while the
> device is inhibited, then the user keeps holding the key down and the
> device is uninhibited. Do we pass anything to handlers then?
> 
> In my opinion we should not. Such an event is "illegal" in a sense that it
> was generated at a time when nobody wanted any events from the device.
> Hence the test to let only those auto-repeat events through for which
> a key is actually pressed.
> 
> However, what I see now is that if a device is inhibited, no key
> will ever reach neither the "1" nor "2" state because of the "if"
> in the very beginning of input_handle_event().

OK, then let's drop it for now. We can revisit if we see that a problem.

Thanks.

-- 
Dmitry
