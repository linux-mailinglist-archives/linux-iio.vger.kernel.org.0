Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4922F9C1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgG0UCk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 16:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0UCj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 16:02:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8476AC061794
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2020 13:02:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so9678301pfm.4
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2020 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=IXDeKj/8CgvwBowlCvSFrtK4qV4sd1hCGAzTc7QYtD4=;
        b=Y3HVXgsRYqk2PJIxygUxaAR7AKRLEORJjoG6eXL600/gkGgOi2sSTJ0j0691Qu0VWN
         JI+1n6sCK5PDGAca2AOtTUa++CMoguByq0quyCD6X7WayrZ8TDfnlWxG/yBUO1UfjdOn
         j0KYrkKQLQNv6UNdXBXDg2Q293ux5L7n7GxFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=IXDeKj/8CgvwBowlCvSFrtK4qV4sd1hCGAzTc7QYtD4=;
        b=E1q+hQ6wPOUUoe5Xmo3nKaOv6yxhFzzBtt3Z7mWCk9VVCCP/FfuayuYJERDENH1hjP
         r3Zrg6ByW5FumvfnIWjFubSKg8SNkSzgGUvXPy3DgUMVA21fYepkncDIaOopajxCDrTM
         OX+bh5ri/VBH+7keQBZWu9Ka5gEhkYAdaLMFcv1qZQ4hNgSyHpXqA/WOHXZvPjocenA6
         m72UpqhjCt4XYPAiTi4soi1N49kOCjFAPaNSTiAAI2va2E5+deIBkNewLES86UYq2zir
         WpJFyM8je0yKYCIve36tnPHBFi2ED8ZclRHd7Zqx2AeoDjoIsBC3lMhVVM9Jay3LMSjN
         4K4w==
X-Gm-Message-State: AOAM5337yvxBtlTX61EPIbEdZNLdTIswp+AUOX8EbpvGxFZH6AxqTIm/
        EIY+Zk6RWCeDf/z5AyxaZfuULg==
X-Google-Smtp-Source: ABdhPJwoSS7iWNG6ib5qqh9HziwtyhV7QAHABX4BFAetR8LGWSTIw5v3Xyvkxa2lVfZQgeiGcZV5nw==
X-Received: by 2002:a63:e24a:: with SMTP id y10mr19769530pgj.1.1595880159038;
        Mon, 27 Jul 2020 13:02:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 21sm15629639pfu.124.2020.07.27.13.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:02:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200726125636.3aa003ad@archlinux>
References: <20200724213329.899216-1-swboyd@chromium.org> <20200726125636.3aa003ad@archlinux>
Subject: Re: [PATCH 0/3] Some sx9310 iio driver updates
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Date:   Mon, 27 Jul 2020 13:02:37 -0700
Message-ID: <159588015706.1360974.7201974727081274212@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2020-07-26 04:56:36)
> On Fri, 24 Jul 2020 14:33:24 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > These patches are only related because I'm looking at this driver. The
> > first one resends the DT binding for the driver that was merged in
> > v5.8-rc1 with a small change to update for proper regulators. The second
> > patch fixes a few printks that are missing newlines and should be
> > totally non-trivial to apply. The third patch changes whoami to unsigned
> > to avoid confusing. The fourth patch drops channel_users because it's
> > unused. The final patch adds support to enable the svdd and vdd supplies
> > so that this driver can work on a board I have where the svdd supply
> > isn't enabled at boot and needs to be turned on before this driver
> > starts to communicate with the chip.
> Hi Stephen,
>=20
> I clearly made a mess of picking this driver up in the first place.
>=20
> Anyhow, we now have two series in flight for the driver that, whilst
> mostly independent (I think) will result in at least some fuzz.
> If possible could you work with Daniel to send me one single series
> with all the changes?
>=20

Sure. No problem for me to work with Daniel. Thanks.
