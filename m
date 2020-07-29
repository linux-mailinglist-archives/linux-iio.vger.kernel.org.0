Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30775231B68
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 10:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgG2ImS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG2ImS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 04:42:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DD9C0619D2
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 01:42:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so1560237pjb.4
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=aXoZD/sjDpEWgC90G0tbRlSg3ouqwk6Z53e9x6lUnWY=;
        b=HE7sii7hRjjmvwiQRJOVtVBeV9zc60V2y/ZRFYjWEIauLK/87smb8yCZAcQZQ7eLeH
         /PNdn74/kEGw5U9SoetNDcwWg9KOtEh4SqEn4EQxKvxB4p+v4qaC/0xNeCp02ANp+Mkh
         RRYhLZbrw9FAEJ1p5c/tNj9pejdsXD352HmNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=aXoZD/sjDpEWgC90G0tbRlSg3ouqwk6Z53e9x6lUnWY=;
        b=o0sSp/R86Hy4puLzW+nR/NlzTj/OtDeuZuI5ovbmxzyEpOExAk75ZVjcPckfOS0Rul
         ILjd63j7+LNr4TnLYqul+3Sgy0gMs7Xa3x+l5pMTs95TgXL3Q3/ZoX54mNOMMvSHS/gd
         /jeIUg68YBMuaIKLFL8otmp2TO1f4nHgzZN0JSgwxmwRnXA8Jq+FnwxfK2A7iKogGGXE
         eJ2LjPXOefXT9hcqASwnTN9jw2FSfdcq/fcFYdf8rdTDlqtKcd18w9I3pTjJfGz+p9nG
         +Nd0jILyBcKGfv4BSWpcTCzeBmuT/4RFVsIjXs1yB0hvf6RavkqVccfslZzs9+mEz2tJ
         /i/Q==
X-Gm-Message-State: AOAM530P+gMiUKr5mGRO9C0AcrRfT5803a25XQLpuuUTcISH64vt6/qw
        1NYiTIe6SK0bKZD9kxAJkGa59w==
X-Google-Smtp-Source: ABdhPJz1X/KuaL0DEpVO+OTg+AJlQykKUWOCJVQK39D8e0v6ixdTAsLkfpq/NI9BVxB0c1I9xGaRXg==
X-Received: by 2002:a17:90a:fa8c:: with SMTP id cu12mr8917242pjb.229.1596012137807;
        Wed, 29 Jul 2020 01:42:17 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id y198sm1591486pfg.116.2020.07.29.01.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 01:42:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728170317.v2.10.I071b118136317d3ff77fc598079f21e4ed0e347f@changeid>
References: <20200728151258.1222876-1-campello@chromium.org> <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.10.I071b118136317d3ff77fc598079f21e4ed0e347f@changeid>
Subject: Re: [PATCH v2 10/14] iio: sx9310: Simplify error return handling
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Jul 2020 01:42:15 -0700
Message-ID: <159601213589.1360974.3536496595430081422@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 16:05:16)
> Checks for non-zero return values to signal error conditions.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

The mutex_lock, unlock, wait, lock, check wait, unlock sequence can be
improved in another patch.
