Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809FE2E230F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Dec 2020 01:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgLXAsd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Dec 2020 19:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgLXAsb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Dec 2020 19:48:31 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EBAC061794
        for <linux-iio@vger.kernel.org>; Wed, 23 Dec 2020 16:47:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m25so1366588lfc.11
        for <linux-iio@vger.kernel.org>; Wed, 23 Dec 2020 16:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZlCM/s5inoFBHbTeX9ckePSWrLvkhghLazOkiDQ5CU=;
        b=DwvA/04hK5QAZvacRMICfpnh0k7jtuMfOXoMrJbMddb/3hnKk44YJ9ejXlwnLJlRTe
         sDWHO/ctvHYIPewkNbMsdnhz8lyZ54tSXU+Trevd/tczABCgJn4D0eCbu0a7cMrk0O0W
         7AWISEG/QnfeQGVlLf0WV6scNJS/JMPC3r3MhY2fSSBJxTCtjKa6+YyN1LAsDJum+FDZ
         YEJVkS802arqA5gVowPr9XfTgcVrnqeAtZT6Q9CXb+do6H9093nl3/CtQGE8LUru16Ot
         TRGJNLhX6XRH1QgapNOJNgAgVuxHkElfKCV5qeVZresNd36aVajSO/w5vPgI4VOM7xu6
         daUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZlCM/s5inoFBHbTeX9ckePSWrLvkhghLazOkiDQ5CU=;
        b=e7OqPKeHn9OF0MR7+dyHZnypauock1V7Ae1hb3f5hTjJLVmJHUI3cN/uc1+3GJTkmk
         l1vpthIvF/YOaDlBIWm+4fg5F0jNl0ScxHN7MvcVnFbSuOA57eO+rfmjlTOQ9oeFYafc
         kmdbEiIyLOckSvsEYQb9gTncqpuSIUIfb2OX6BetPevlrffPDcLZ1p8hYUTIaybEnQy6
         2i7rwrIQBBj1CkJz73WL88uQ0Bs6fT7o2Rijaq7iMaesSDPGVYvU8DVcsrXq6Wb2s3XN
         /A4yTCsxT3QqOzbE5kUhR5187RDflvH0hPBDpidFNzunFfoFRsBEdArTNYhxAsaIqNdB
         dAOw==
X-Gm-Message-State: AOAM532zyUyqWJ8n33f+8zjwL0l4T1d3c9vL/ZYyRnYJPlJ4PEdy9fhP
        oP4GAqIBo7DOkzekq79eeIq7nr164aDnzM1jacITog==
X-Google-Smtp-Source: ABdhPJynkfaBBPhvDJ29DhdHxZriI3DBy9ij/buMqyGfRKBWSHlt9gDM/HgyikhM8tss7BQ6NJyUwlut6CnzQ/w8JE0=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr11574604lfe.29.1608770869693;
 Wed, 23 Dec 2020 16:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20201219224143.686074-1-linus.walleij@linaro.org>
 <6d339a6c-6f8c-4a5e-718b-c90a9fbb8c01@roeck-us.net> <CACRpkdZTVAoDbbJqTJbxv1ZDyAMsB_h9TAdKKbxqBYGp4-b_jg@mail.gmail.com>
 <d990e08f-6f18-836d-89a5-01102a4faa45@roeck-us.net>
In-Reply-To: <d990e08f-6f18-836d-89a5-01102a4faa45@roeck-us.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Dec 2020 01:47:38 +0100
Message-ID: <CACRpkdYJSE_wSf72N=oX+JogdTF-FBSqkeMZghrr1ytmPY8apQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (ntc_thermistor): try reading processed
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 23, 2020 at 10:42 PM Guenter Roeck <linux@roeck-us.net> wrote:

> You don't
> answer the basic question: What should the driver do if the iio
> subsystem only delivers raw values ? I suggested we should just keep
> the current assumption in this case, ie do the fixed conversion,
> and let userspace handle any necessary adjustments. You seem to object.
> With your patch, we get a comment in the driver suggesting that some
> code should be removed. In my opinion, such a comment comment does
> not add any value. Ether we drop the code or we don't, and I dislike
> removing it.
>
> That results in my usual fallback: When in doubt, do nothing.

OK I get it, I'll fix it up along with the confused bug pointed out by
Chris and resend.

Thanks!
Linus Walleij
