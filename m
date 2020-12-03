Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115BA2CCF2C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 07:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgLCG1u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 01:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgLCG1u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 01:27:50 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450EFC061A4D;
        Wed,  2 Dec 2020 22:27:04 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id r9so538189pjl.5;
        Wed, 02 Dec 2020 22:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HbJt6rJA01QCvzasS4bsjMswEGXIMUsY6Sd2CuWo+TA=;
        b=dVxEWp/RvZDYdBHbNkIa716w8SrdD3Bx6vfJPohQ0OY/cKAqNuPT4RBfPrmRvG0bYK
         cdFDoQiBbwaCt8XKFTDl5hC0I2JzBvKpljBGUkGC9ndGlccVEe/kYwkw7WBcKhdqGn2H
         pOi1ZBiDIO6A3GAeoU7/o9bEHcB2S0TJGTmxdkYI1QwTdN4/wspINEUxRbUk1Sfd55vN
         wUB9lCevCMcTWq74lHPkjJiyP/EMoLSzXaK8aIkNjvZnE88DUJBZdagqZWqlI+fNHBBK
         8NKV6uP6PN1rE/aWSmY2qW8BnbMfd4KKtDSki68dYhes24N+RIyMjlzqNeTtW+6rgEqD
         FzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HbJt6rJA01QCvzasS4bsjMswEGXIMUsY6Sd2CuWo+TA=;
        b=fSb0sBjOtDtA40/ichtv47cknP8EWQBftLrre0fREaqZNInmgPm8gPlf46OHFUabaP
         PRLZkzKdCrSYWhWipvmCx16jBbmhTu3hI6j0y6kc/aupky51cqSL7FP4hZFDYGhcRJlL
         lV2JtKWBuBIkUMoDl1FFwG9IoYV6id71nrfILypQFcg4GGq1+bN5c8efxQ9u7OgO9am7
         QnusbV57RuUtDHMRhmWt04EBEeZsMiRaYmS2TEdNcIboRLwvNeLztF+kCsE5IN2Pw7nY
         t9PzwYSozQvJD+/psk2d7glgXmLB0Zk97h3lwODCiVtZM9rey+kfimcDdpX2y9Uewtt/
         A4Xg==
X-Gm-Message-State: AOAM532xhtYEgMHrChRbtWr/dcEbvUKHyXtK+Fo4S4FPuoDfuX4WmhXX
        7VQIpA60CSICoyhm/aBBy94=
X-Google-Smtp-Source: ABdhPJxLIrp/Z8QgkGxETX0iBcSEzO8X/mrXwjgbBiDfZrpesga+0Jq3qeSuLPnrQoJ+EjG3lKhetg==
X-Received: by 2002:a17:90a:a501:: with SMTP id a1mr1531028pjq.4.1606976823776;
        Wed, 02 Dec 2020 22:27:03 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id gw7sm283892pjb.36.2020.12.02.22.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:27:02 -0800 (PST)
Date:   Wed, 2 Dec 2020 22:26:58 -0800
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
Message-ID: <X8iFMp5jjhxR2xrr@google.com>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-8-andrzej.p@collabora.com>
 <20201005181014.GL1009802@dtor-ws>
 <ac4eeab7-8333-b96b-707b-eb2d6d0d8139@collabora.com>
 <20201007011102.GR1009802@dtor-ws>
 <20201007011249.GS1009802@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007011249.GS1009802@dtor-ws>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 06, 2020 at 06:12:49PM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 06, 2020 at 06:11:02PM -0700, Dmitry Torokhov wrote:
> > On Tue, Oct 06, 2020 at 03:04:28PM +0200, Andrzej Pietrasiewicz wrote:
> > > Hi Dmitry,
> > > 
> > > W dniu 05.10.2020 o 20:10, Dmitry Torokhov pisze:
> > > > Hi Andrzej,
> > > > 
> > > > On Mon, Jun 08, 2020 at 01:22:11PM +0200, Andrzej Pietrasiewicz wrote:
> > > > > @@ -284,8 +284,11 @@ static int input_get_disposition(struct input_dev *dev,
> > > > >   	case EV_KEY:
> > > > >   		if (is_event_supported(code, dev->keybit, KEY_MAX)) {
> > > > > -			/* auto-repeat bypasses state updates */
> > > > > -			if (value == 2) {
> > > > > +			/*
> > > > > +			 * auto-repeat bypasses state updates but repeat
> > > > > +			 * events are ignored if the key is not pressed
> > > > > +			 */
> > > > > +			if (value == 2 && test_bit(code, dev->key)) {
> > > > >   				disposition = INPUT_PASS_TO_HANDLERS;
> > > > >   				break;
> > > > >   			}
> > > > 
> > > > Is this chunk really part of inhibit support? I'd think we cancel
> > > > autorepeat timer when we are releasing a key, no?
> > > > 
> > > 
> > > When I look at it now it seems to me the chunk might be redundant.
> > > But let me explain what I had in mind when adding it.
> > > 
> > > It is a matter of what we do with input events generated while a
> > > device is inhibited. If ->open()/->close() are not provided by the
> > > driver then inhibiting amounts to merely ignoring input events from
> > > a device while it remains active. What else can you do if the driver
> > > does not provide a method to prepare the device for generating events/
> > > to stop generating events?
> > > 
> > > In this special case a user might trigger a repeated event while the
> > > device is inhibited, then the user keeps holding the key down and the
> > > device is uninhibited. Do we pass anything to handlers then?
> > > 
> > > In my opinion we should not. Such an event is "illegal" in a sense that it
> > > was generated at a time when nobody wanted any events from the device.
> > > Hence the test to let only those auto-repeat events through for which
> > > a key is actually pressed.
> > > 
> > > However, what I see now is that if a device is inhibited, no key
> > > will ever reach neither the "1" nor "2" state because of the "if"
> > > in the very beginning of input_handle_event().
> > 
> > OK, then let's drop it for now. We can revisit if we see that a problem.
> 
> And by that I mean that I will drop it myself, no need to resend. I will
> be applying this shortly.

Well, "shortly" was just a tad optimistic, but I did apply it ;)

Thanks.

-- 
Dmitry
