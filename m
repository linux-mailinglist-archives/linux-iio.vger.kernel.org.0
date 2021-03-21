Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A5343592
	for <lists+linux-iio@lfdr.de>; Sun, 21 Mar 2021 23:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhCUWyy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Mar 2021 18:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhCUWyo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Mar 2021 18:54:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58540C061574;
        Sun, 21 Mar 2021 15:54:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e14so5563029plj.2;
        Sun, 21 Mar 2021 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gk6A8338xa9+KOeBrbrS5yYzBt071QVtFCzWrO9AcMk=;
        b=iul765MCvW2akaWYSsRnEb7Pja9iVxTY14WAIQtFMF9rZ0qUAFeANpk3IjHtj5EPAi
         Zb6/7mcHqrcr0TGX8SR8yJcRBAbvb81Aytr6jPyKEW/c9EhS3R36GXubtVdQj0DzyO4n
         O2yi9d8dXBCgtI4cBsvb66wpHAq1hRyjIZqbmvn0IRk47iPUta6ZYwj/D/3A2KN+o/J2
         5oL5wdULWZC2C8xjJa29OH/eglYf0sKtH0/73uJ0DuxHS9R6qiMxqiMZ3aMwMPmilfNU
         U4k0vNauK6mvB3QkEoT6s2zbKUWDiW9hzxhO8QYmAYlcS28gVEvabSfTQNmsO5MDQDFp
         sP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gk6A8338xa9+KOeBrbrS5yYzBt071QVtFCzWrO9AcMk=;
        b=SbxubZ66K3P0xLdlr2aeh5ouqF7Mtq1ASA3NGnvCvJ5S1/QV5PQXhA5WJEIsdwHmLU
         OU5K618OvLFTlVH+HzQ52nyri9s2IIkBe0HrwdOxZ6PeiVsxcSpvru36LEEJt3Tj9tJs
         d+w7SpEEgIjFAF8XJt5BMr/GFm0ILAq5AsE2nqYVBA6Gmeiv4WU5BkUy5b9o2TFj459w
         yRwYdn25m8n4JvSz2zrifB/cR50GWzLieHtf5B1N4AXnpf9nyPjO+7difu8p3Hc1+6kQ
         pKWA/OHzJ0aONdeCZpiDD/uHsIVDUGy8WUCCMimRBazvj6ubPckSgxK3lxLSV6IYuSw2
         XZ/w==
X-Gm-Message-State: AOAM532Gf8ppmU3ksddf4uAj0CNjuDFWck94rGRrkUEFxzVVaSgaryor
        PghQGoY1+G2OD9i39Uhtb7U=
X-Google-Smtp-Source: ABdhPJwUjKiwUIY2gR5v0t68n+s9S9RHxjh5tdqqi5s1ZgiTiLbNiorDYfl4POuOp7e5pSoWylxI9A==
X-Received: by 2002:a17:90a:fa89:: with SMTP id cu9mr10261658pjb.204.1616367283943;
        Sun, 21 Mar 2021 15:54:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:85c2:9df1:533a:87e9])
        by smtp.gmail.com with ESMTPSA id a15sm11643646pju.34.2021.03.21.15.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 15:54:42 -0700 (PDT)
Date:   Sun, 21 Mar 2021 15:54:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: More cleanup of standard unit properties
Message-ID: <YFfOr27g5cGFvwNR@google.com>
References: <20210316194824.3526913-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316194824.3526913-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 16, 2021 at 01:48:24PM -0600, Rob Herring wrote:
> Properties with standard unit suffixes already have a type and don't need
> type references. Fix a few more cases which have gotten added.
> 
> Cc: Luca Ceresoli <luca@lucaceresoli.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kevin Tsai <ktsai@capellamicro.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
