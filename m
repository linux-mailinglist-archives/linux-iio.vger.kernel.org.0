Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FCE363B40
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 08:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhDSGGp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 02:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDSGGo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Apr 2021 02:06:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AEEC06174A;
        Sun, 18 Apr 2021 23:06:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i10so18196316lfe.11;
        Sun, 18 Apr 2021 23:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Qk+RkRzDC2RxMA9iVtxLQ0qZjKIyiZ7SI3o9mYd7cUA=;
        b=pCLU7XvjOqCkEHHV3MkifI+9WYJuQX8/wVTrBOE7x5Imxbn1c6gHnVMbCz+ip1igqx
         qWX5bzOYp6kW2kN1/4KadR3iBMlYER/05Yaj7YoeXtSNsNzsJCYvMe01Mse++X+MVHAS
         n2+23ov9dURUhAM8RJl6vRIwXbTQf1jkPoas7GdBRL4Js00hJIWo1F6IkQO9FJ8dcyZ8
         WUbS3uzQv2o81yevvTDd1Ahe3d9EbMY8AP0GpC7z7zxx05KavZdWGexipLYBMGdBvRAN
         X4w0YpfbNcAHXHJNTg0Jay8+0LGXuupdpdOXCOec1SFFkuYBmuVVKU+rDDtVRFQkbKF6
         ezGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Qk+RkRzDC2RxMA9iVtxLQ0qZjKIyiZ7SI3o9mYd7cUA=;
        b=aeKTihapjKAIA9hxzhKN510onbSdPyYbrqFOiXS8FWv3Nw+bH/vXna8ckPH6CtEgEa
         tVVxrUe6fESHL6HB0/0gQpfVudf1KSLfbds0RbOTdO/Lx1yunKgtEfBN8JQk7cq5nwXp
         fWQT23SZQk3W6w3zTUDdD8CGn1/9b7aVrFBAr57cbNc+nl4NJZht4WLnsPKozd7GiEOw
         b6xYY8Z46oIsvP1ZmBnEGVF6s0FBGC++Kl2xyNgrc5Beeahd+4jPeFsCpXg76TK1MTWN
         Q+ppuqhbSixSjsqHUWm7lt2fsyNN0EI/3lEspt7FjEWLLcJpncYKkNK64k5eXKBu4LPe
         CuvQ==
X-Gm-Message-State: AOAM531xRz7d9Dc0iIStgjFL5rOr2BkbTcacZFqsOtJa6NjgEqEV0tU1
        tYVHPYQfdIrOUOpOdJfg+z1OoLLAF6k=
X-Google-Smtp-Source: ABdhPJxDdgAoLEZe1YRYBSsAOnIKMJwZH5RNdcoqdiRKASztvqv2zRCq4Y762ISnDyLceIqur6dI7g==
X-Received: by 2002:a05:6512:1286:: with SMTP id u6mr10847235lfs.377.1618812374061;
        Sun, 18 Apr 2021 23:06:14 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.googlemail.com with ESMTPSA id c11sm973332ljr.70.2021.04.18.23.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 23:06:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
Subject: BUG: iio: mpu3050: Wrong temperature scale
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Message-ID: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
Date:   Mon, 19 Apr 2021 09:06:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Svyatoslav and me found that the MPU3050 IIO driver reports temperature
that is x10 larger than it should be on Asus Transformer TF201 and Acer
A500 tablet devices running mainline kernel. The driver uses
(x+23000)/280 formula for the conversion of raw temperature value, which
gives 82C for x=0, thus apparently formula is wrong because x=50000
should give us ~25C.

I tried to search for the datasheet with the formula, but couldn't find it.

Linus, will you be able to check whether the formula used by the driver
is correct? Thanks in advance.
