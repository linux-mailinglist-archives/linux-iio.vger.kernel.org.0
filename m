Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FC22312F4
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 21:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgG1TnB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbgG1TnA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 15:43:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57F8C0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:43:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z188so3710655pfc.6
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=vnxwi5iPCJkQKF4flCKDFiMcmGVkTk/FZPhjrVn7vQ8=;
        b=lGILnOI2EA2ePNYpXzRAJhVcrhFB5Z+3mS7RTR0wzoPvklGepKua58mr9TZ3zuL0VU
         dYg64ioAyhPP6TnZY+ZxqgWDb5liZYowK2t4+fhaQCN+o5WeoEU0z4A6AXz1+4TQ3fnr
         Zbge8OACGr5Fj8DXtHimT1BBBOOPSv4jI1IKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=vnxwi5iPCJkQKF4flCKDFiMcmGVkTk/FZPhjrVn7vQ8=;
        b=N2yWy/WF3qXk1/J7K5qzsr+l/ASjARRVYgVRg3qY2PI1CitknanEXPN3pGk8XNPWBW
         qTppIRyjmG5nICqnEkCavRDH6hW7SCFXI1LA+RFCREYZrPji8QEdtxxmzx1q6mLnJPUh
         x7fkEK6nCDTmy8b/RG6116fOF5gognQshlZleygs/6fHUnDETbo6qkrDDgqjROBtp+hw
         5ugUjUOJHzNCepOME3jaf1AWX1yaZJcKDTsXSvpSSZkQSKq3F0nNTU4bt3NjZQ1QQA/c
         3osOxt6nCoPBpYOS55438Qo1CqWn+lfVIqZZ6jozm2b77+9FqaVF+iCODTPUCSRLsGaJ
         GP9w==
X-Gm-Message-State: AOAM532vrXROQyKnf+o76oghuQu6IwCl62qE6Bw8t+nxi5qNlMpkX1se
        Cwv4WoUCbdzjzXSPkl5AxPQuow==
X-Google-Smtp-Source: ABdhPJx/Gpp+X34yyUGrc2pTEF69GOO3vQr5iwhFpQeyJ7MgTI61ZKxOdL1srQX1mC2VDW9ZhI+mXQ==
X-Received: by 2002:a62:2e45:: with SMTP id u66mr1993692pfu.121.1595965380254;
        Tue, 28 Jul 2020 12:43:00 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id o11sm19315046pfp.88.2020.07.28.12.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:42:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.2.Idb6af9292f18f54be0b62cede52b481063738707@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.2.Idb6af9292f18f54be0b62cede52b481063738707@changeid>
Subject: Re: [PATCH 02/15] iio: sx9310: Update macros declarations
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:42:58 -0700
Message-ID: <159596537832.1360974.10421899531703700889@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:45)
> Follows spec sheet for macro declarations.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
