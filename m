Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEAB2312E4
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 21:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgG1Tl0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 15:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgG1TlZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 15:41:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFB0C061794
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:41:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b9so10497039plx.6
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Tt1oB5/JSSIBPEzmzmS6Al56/2k10JRnudrRTsEkyZQ=;
        b=VuMywMwH4C3Ma1CCFFnox7L/OmRNnabVKzronEoZ8l7QdrS7X5/ruXnrNyq8alv7LW
         1G+/r/eNciDtwh7ZSnopK2Fs3z33cMoCMidZlzUQcmIJNqnMerfcU6fFrp/yg9J5Znc0
         46kAToYneS/NNtzmdKWno8JYWL3gg2S10G+qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Tt1oB5/JSSIBPEzmzmS6Al56/2k10JRnudrRTsEkyZQ=;
        b=rD95wINhghIQmOYRnpbHjwAFub4dzzsIuq87Mj6LH5bEmp4yuBRu/wi6of2twhZbpp
         h918QqmcOqHVNbf6kxNlhYb/0h83BboFNVRcvwFMHAVde62OikBRGCYVA+g+8TJG5PNg
         rYRM2cjcwsdOMlHdVvMHOMUCZbNfVFTBu21qcbB/5SeZIe7+hLBZ5gFXxoROX+1Xb7uZ
         OJuSuEdLrC248MUZv5esxWCyci5Z8rPArd0A4osozLX4etSAJTp7j5sBwoSRHPA3JozP
         EAobyH7YiuaekSvDdH8a7eirOKE+MUX4v2/FhHoyejfaMT7WOCcSA5OK+w4uP3oWjq2t
         ZmHQ==
X-Gm-Message-State: AOAM533YgxtNWyKmexnsJONHOrECgt30N+tfG2iBNnRZhQIjXpBrLmY+
        grLDggYclA3yFyi0Wy3rIW8D3w==
X-Google-Smtp-Source: ABdhPJwlkYDk4n1LB04qDyenqfvxkpJupbQgya8o8bgR/rB9e/SY9pWSIBYqYLvMJRDPFGVNQitSoQ==
X-Received: by 2002:a17:90a:2a09:: with SMTP id i9mr6035315pjd.50.1595965285476;
        Tue, 28 Jul 2020 12:41:25 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id o16sm5792491pfu.188.2020.07.28.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:41:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.11.I126c3f697e0b7ee951ea24ac60ce79d368790de9@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.11.I126c3f697e0b7ee951ea24ac60ce79d368790de9@changeid>
Subject: Re: [PATCH 11/15] iio: sx9310: Use variable to hold &client->dev
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:41:23 -0700
Message-ID: <159596528373.1360974.13960095456763695577@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:54)
> Improves readability by storing &client->dev in a local variable.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
