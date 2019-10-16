Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE46D90A0
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2019 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfJPMUC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Oct 2019 08:20:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42098 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfJPMUC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2019 08:20:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so23745071lje.9
        for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2019 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xURgktbGyoLOOU0mmZr5npbnYYqmq5Cf5Inf6ReyMm0=;
        b=JhGbMPViD3GpPspT39YPkIg9bMffLsh1GhWw9ix7Z826bKysq3MfgkPYLQzWGR6+wN
         DI15xxrNxoZb917/ErtXNWXG63ahn2qNH32t26wOz309nIo33jHfJcjglWMd3SDaO5Gp
         1R0F+Ull9vSB80aR4YDbAyP4AzgSUhJ4hOqeNXTsvVjW1eEsdgiR/E5yOfr+G1vv1Uqj
         GIr8lzsOG2vhlM7dEdTy9uGZ6GApAMGgmYWh8wbNaEDra9FmAhfmXwXRIkPudT18fX34
         Svujg37bCAJWvuS4daeszgZtpakQpEoMV33FxO5WLS0rDwsklNGwpzCGiabpPbTVmFB1
         iXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xURgktbGyoLOOU0mmZr5npbnYYqmq5Cf5Inf6ReyMm0=;
        b=gwl6Sj97OUdCEdl/kqY7DJxZzfKToGM64KVk1mA3gSo64zOzvS6kHlDChPGnoauZAA
         7yx6PaWrf0AQiju8+V0mokO1iRJ7xZkvJ07mbTtH5OkqDjr8cyn1NjE3s2G1Y+BwYaBj
         0qS5KxeUr3/xBdw4si2hn4Lb9av3cbDMgVy84mcpR5D8xJ1/xOOXM0BdLl2Hm85H8Zwu
         YDdrMbE/W2T+SIxraAaDpceDgJzJBRbCGax/bW1LfQ+b4a5Ip88r7PppQAG5H/0L9rEC
         JFo3597ieMVAa9Gs0CBeIXkJ7110pF+0qmBLG+MQjZIAzJRRrLjoAVWvvHyw1kmXjyfT
         EewA==
X-Gm-Message-State: APjAAAUolfismC+70TNqCznC5vBCVStllH90QHyQcnavHGR+WFlinFmF
        /9ngUDWTq9O/qQOOFsxs9DS+G88RkoRLyd5tcgWH2A==
X-Google-Smtp-Source: APXvYqwNGRlMqP8/IwF+IZ+5d5cqO0PenwaEA7nQfYn8GMrZXyzeZlHukUChGDL5vdOWZ8zUYNyEqsn65Oah32dBmg8=
X-Received: by 2002:a2e:481a:: with SMTP id v26mr18286067lja.41.1571228398539;
 Wed, 16 Oct 2019 05:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191013100255.1445528-1-jic23@kernel.org>
In-Reply-To: <20191013100255.1445528-1-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:19:46 +0200
Message-ID: <CACRpkdb71HM0QmmQZtb0=KYPNWLtknPq5Z_gsmAb-SdbQzAQ6w@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: Explicity make a 'poison' value big endian
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 13, 2019 at 12:05 PM <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This clearly has no actual affect but it does show sparse and similar
> static analysers that we are doing this intentionally.
>
> CHECK   drivers/iio/gyro/mpu3050-core.c
> drivers/iio/gyro/mpu3050-core.c:546:48: warning: incorrect type in assignment (different base types)
> drivers/iio/gyro/mpu3050-core.c:546:48:    expected restricted __be16 <noident>
> drivers/iio/gyro/mpu3050-core.c:546:48:    got int
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
