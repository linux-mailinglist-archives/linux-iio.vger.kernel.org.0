Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B941F1284
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 07:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgFHFhm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 01:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHFhm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 01:37:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A55C08C5C3;
        Sun,  7 Jun 2020 22:37:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ne5so2810589pjb.5;
        Sun, 07 Jun 2020 22:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RTapcU6gK7wVagdpIBy1syxYRT4o5dx2x3mb/55IfwQ=;
        b=DITjcqepAg/aiVMxe1Gh2awTCmo91vVu3S9mlVdU3hgfcPrStCTsiH/eLXmFFx4VRn
         o+ChFk5Yofnb659Ehd5fQWdqZmVijpUVnFuGNuFhMOE72kvC1E3+mfpKEr/ZswrbVsJy
         sipQ8XyZUaVEwcIfHzLeHoRReoDiJt10fqtwJ3c4BO29KFNyabOsxQSftZ67b+4X3i7i
         XR9li74InWK9fBIdE0y17Jbyz8DsjgWa/+fMyP1yne5aCzj4UJD1nLwMXWmxvqe9Spvq
         wc9P1vraN5a+3iQ96WNuaUdHrp7GU+r2Ij6WnopwS0BjnouSD1RBVYKA1uSNqvSLb6Py
         s/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RTapcU6gK7wVagdpIBy1syxYRT4o5dx2x3mb/55IfwQ=;
        b=mGHQBi0X0VUkABufhg1+Ev4KMP42P+k50fcovQFKnSKOF2ea/BrHawmIGd4egpI30r
         a7juQPETJ3JbxVxWf7pdRiwVx52iHAiY39QupBk6wn3W/c2dspeFWGBc6v1knh7hYdAY
         T4XewmmbvKlPz70DTG/zvpsnGxLtJoaKMXCMqiCyBiKHz1c+s6DcbS12cIJmv+Ngt9wq
         Ci5vK26b7dreo4sMMpLKLt2qOMdwQZ9v+lwWlHHkOK8/7IdnA4dsVpgXGcg6x89IDxsM
         IE7wg1o5PsYpKn/u7ULuF8Hqjap+oQweW7b0lf2/IZajDIjhEjcAEMaNJZXxjwnv6rV3
         wnYg==
X-Gm-Message-State: AOAM532mYJAlZHifT2eiitCzUn7x4pVBDH9g7t06sP0lLO7H4JzQxcyc
        YgCQKVM09me4iG/znjO9RhU=
X-Google-Smtp-Source: ABdhPJzN5CaIdVRcGxuqJwlU7nQJooHDxxicu9iq+KnTRKt689A3cjTNxnb8ofRVOYLQTpNcwc0RwQ==
X-Received: by 2002:a17:90a:c283:: with SMTP id f3mr14534964pjt.166.1591594661380;
        Sun, 07 Jun 2020 22:37:41 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id k14sm4926474pgn.94.2020.06.07.22.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 22:37:40 -0700 (PDT)
Date:   Sun, 7 Jun 2020 22:37:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
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
        kernel@collabora.com
Subject: Re: [PATCH v3 0/7] Support inhibiting input devices
Message-ID: <20200608053737.GS89269@dtor-ws>
References: <20200604072853.GP89269@dtor-ws>
 <20200605173335.13753-1-andrzej.p@collabora.com>
 <20200607202414.GB13138@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607202414.GB13138@amd>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 07, 2020 at 10:24:14PM +0200, Pavel Machek wrote:
> On Fri 2020-06-05 19:33:28, Andrzej Pietrasiewicz wrote:
> > Userspace might want to implement a policy to temporarily disregard input
> > from certain devices.
> 
> Wow, you certainly cc a lot of lists.
> 
> > An example use case is a convertible laptop, whose keyboard can be folded
> > under the screen to create tablet-like experience. The user then must hold
> > the laptop in such a way that it is difficult to avoid pressing the keyboard
> > keys. It is therefore desirable to temporarily disregard input from the
> > keyboard, until it is folded back. This obviously is a policy which should
> > be kept out of the kernel, but the kernel must provide suitable means to
> > implement such a policy.
> > 
> > Due to interactions with suspend/resume, a helper has been added for drivers
> > to decide if the device is being used or not (PATCH 1/7) and it has been
> > applied to relevant drivers (PATCH 2,4,5,6/7).
> 
> But is that a right way to implement it?
> 
> We want this for cellphones, too -- touchscreen should be disabled
> while the device is locked in the pocket -- but we really want the
> touchscreen hardware to be powered down in that case (because it keeps
> SoC busy and eats a _lot_ of electricity).
> 
> But simplistic "receive an event and then drop it if device is
> inhibited" does not allow that...

I do not think you read the entirety of this patch series...

Thanks.

-- 
Dmitry
