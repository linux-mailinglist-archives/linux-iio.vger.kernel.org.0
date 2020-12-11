Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6DB2D71C1
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 09:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgLKIc3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 03:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgLKIcC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 03:32:02 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD0C0613D3;
        Fri, 11 Dec 2020 00:31:22 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id m5so1972886pjv.5;
        Fri, 11 Dec 2020 00:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4zPFRNJq7ChgGn6x1xRHPz16KRlRzGnYElHimU2a+ik=;
        b=mB3B90PTK0IhVY1R2bpq5cXTcrpAgnpH7bH9MG5eYBLl9ySVrfD34JwfyKv86oVOO2
         cDIzStmOtmsKsvdG/iT4i6wekuMnWgB0ranqUq0eQRQorGNfi+etBI5781L0QT2XMr+E
         QHUK6op8ediMKZPm1gkI8HweBBQgTulyamv0PeJIXE5L9/6n1b+OiSRoIaFDrfmpP/bT
         DatGLglQJixZuub99A6SS+6aVNzm+GJNEd29b6D5D1qYuUxQKWj3kwtINrbvAmOSjRrf
         weN9ctehM3LgNCf4J7Bd6hxMJWju4rk83bU7dSq62a9hPpBWlCfvVZF0aS/Fl1vYhjEB
         PXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4zPFRNJq7ChgGn6x1xRHPz16KRlRzGnYElHimU2a+ik=;
        b=SJTAm2h3M7qH5MF9OqS2BgnMS54p0YPOJIof+w6IqMsJ4caHZNYGnlJCA/M+xzJK94
         MhD2Kw2PImBcE30OIQoSYgxCC9zltzMuZBaMMm5K9/rYj6QyfJLf8EzYIGdQrIi//D1K
         Al61JspK9ks45G5/Jchiz98NPSBkiRK0O4kqJ0heqru2HP7xnHtvl0HWsPbb3YbQx5y+
         y9IeMkXe/OcemoFjGoGsaX+IhSyr1gPxf7z4wjywSuMnW4/oLupCgDyUs8y2TOSXfMhG
         0cD2O9uVKUBLs39cK8UBW+yZYcFglQZdvB3rk/5JuR53Xc5ZcAl4u4exne2rFokr2eHZ
         rFHA==
X-Gm-Message-State: AOAM531jNfNOwy2s4ifZC3KUzRZmk2gw/uQBIXWZ4kFNlNgCH6I/JJEC
        ve+b1cFElBmwpbHpfNNJ3L0=
X-Google-Smtp-Source: ABdhPJy5hbCygYTmShS5aFbZ1YVPeTgb8RVJaseat9jLQIAFHFQ+8RbQ/NYOYxQFRvRqk+3sJqx0Pg==
X-Received: by 2002:a17:902:fe02:b029:db:c7fd:3c2c with SMTP id g2-20020a170902fe02b02900dbc7fd3c2cmr10050492plj.31.1607675481748;
        Fri, 11 Dec 2020 00:31:21 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id u4sm9029469pgg.48.2020.12.11.00.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 00:31:20 -0800 (PST)
Date:   Fri, 11 Dec 2020 00:31:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
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
        kernel@collabora.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] Input: cyapa - do not call input_device_enabled from
 power mode handler
Message-ID: <X9MuVAaRhv/D7vYU@google.com>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-3-andrzej.p@collabora.com>
 <CGME20201207133237eucas1p26f8484944760a14e51dc7353ed33cd28@eucas1p2.samsung.com>
 <27ce1176-6318-45aa-4e22-3dec9f3df15d@samsung.com>
 <9c784a23-eade-eacd-3e67-d344a5758b83@collabora.com>
 <ad093ba3-7b17-18f3-6bb5-d8133c3da89a@samsung.com>
 <X9BwtHs9XriwR8gL@google.com>
 <X9MbMja+TEfbKkmJ@google.com>
 <fa0e07b1-dee7-9b44-897d-66095f2eab90@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0e07b1-dee7-9b44-897d-66095f2eab90@samsung.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 11, 2020 at 09:22:44AM +0100, Marek Szyprowski wrote:
> 
> On 11.12.2020 08:09, Dmitry Torokhov wrote:
> > Input device's user counter is supposed to be accessed only while holding
> > input->mutex.  Commit d69f0a43c677 ("Input: use input_device_enabled()")
> > recently switched cyapa to using the dedicated API and it uncovered the
> > fact that cyapa driver violated this constraint.
> >
> > This patch removes checks whether the input device is open when clearing
> > device queues when changing device's power mode as there is no harm in
> > sending input events through closed input device - the events will simply
> > be dropped by the input core.
> >
> > Note that there are more places in cyapa driver that call
> > input_device_enabled() without holding input->mutex, those are left
> > unfixed for now.
> >
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >
> > Marek, could you please try this one?
> 
> The warning is still there:

Ah, yes, we are hitting another instance right after setting power mode.
I need to think more how to handle that one.

Thanks.

-- 
Dmitry
