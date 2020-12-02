Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1AE2CBC46
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 13:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgLBMC0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 07:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgLBMCZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 07:02:25 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A091C0613CF
        for <linux-iio@vger.kernel.org>; Wed,  2 Dec 2020 04:01:45 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l11so4323352lfg.0
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2020 04:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Jge0AZmM5VhbzuiyqpfqNlT4/Z2ZHHTG/GS2FKWKoc=;
        b=FHJKpbyUD7UdseRGHSJzU6tH8fFIjPQooi0W3k5kpQppkyDYM4mK15X7nmTYDqh5Dk
         094sUyUh47eaJDlaqjL6kYKPk1/ESEBKxB5n+qzrNmwcISu3O7ZwgDarBCnCV+bjb/w5
         Pvlw7byt9quCtJIYYtQBkU474xeVpgZ9mAgaQmUbgeIwhF/sZTXRWkRrgXGGOlY/rD9+
         lYSpvPVbjU3K0ZOeNM8/QWl49hMPunzsWxoQr8pYxoLoPASWzmmdiOQcDJQ2N75uhx6r
         pzifeqBhsB0Z33qyYs8NgptYGKXpY2bOn7T37dNMJHJ6bbug1EK/m8RAO8hmA6AfTyIv
         Q6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Jge0AZmM5VhbzuiyqpfqNlT4/Z2ZHHTG/GS2FKWKoc=;
        b=A9uejd+beUYMbytdwGtheM3qwR1UMAfyK/U26XE6oWWigKNRTNOLyd5XE+5BdGlVIq
         XkgPNevtMeKLPBmqVFDPT8hp5Er8XwzeZGfJM6HCaSEBezzAkK50VaTVUiTdeGbNmj8e
         nilVuK+ahKGzCQQwvgUYJCqgVYNyQPv8a6XsWQLzG2dVEDycH7+PQpuHctItmn/T24Zq
         e3ufe9I89w/uAUHlTp2Gjhjv1Pt2ud8Ipf9LwEcgXrZ8BfA9P6XTdHJxryt4JKPkxqDV
         IlLTEclDS5MhZr3MwH2/JKZ2M0oypCLuhoGsowglbuwF7WPJcdQcl8vfBle3xUD+lq51
         jMeg==
X-Gm-Message-State: AOAM531SOy2uzqJaNlViSWD19vdzXceAvCZQLuhYi9q5tcaHWclJBQi8
        DPw+yG98u3HqdAPu44heCiOCM99v6OjZK/lSjd9YbA==
X-Google-Smtp-Source: ABdhPJzD1YiNTYiIBlPX6kBOgTaYp4jyRfdc+xatl+ocbJcl6wSgJ0veqI4AW0JfK2e1BE785dbfbCOvp3K4MWXAmRU=
X-Received: by 2002:ac2:4308:: with SMTP id l8mr1046520lfh.260.1606910503534;
 Wed, 02 Dec 2020 04:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20201202093322.77114-1-stephan@gerhold.net> <20201202093322.77114-2-stephan@gerhold.net>
In-Reply-To: <20201202093322.77114-2-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 2 Dec 2020 13:01:32 +0100
Message-ID: <CACRpkdYZJKQyMb+6EeN9m+y3VufX8b2D8FHviusVh0uJ7v_FSA@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: magnetometer: bmc150: Add rudimentary regulator support
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 2, 2020 at 10:33 AM Stephan Gerhold <stephan@gerhold.net> wrote:

> BMC150 needs VDD and VDDIO regulators that might need to be explicitly
> enabled. Add some rudimentary support to obtain and enable these
> regulators during probe() and disable them during remove()
> or on the error path.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

LGTM:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
