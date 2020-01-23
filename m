Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBED6146CCA
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2020 16:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgAWP2l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jan 2020 10:28:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42257 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgAWP2l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jan 2020 10:28:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id y4so3885526ljj.9
        for <linux-iio@vger.kernel.org>; Thu, 23 Jan 2020 07:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Qr9BdbkkgkuLaABxg1maqPFbi8IH41Lo7L1VxAqiyw=;
        b=iGZFnSn+vi28+z3do2lW+WbQQJIwuMVk+nTR6JGwyfDav1RKSSd7CcJ6KK6LcpVCo2
         0fiNppfjuAfjdpSLuQenKgpCS4QV+Vufpcl2FY4z+ARDLnP0QoKMSlqBVFoiIMk4AcaP
         lY10C7psqauI55WjsxDwb5YlBe6knaX/slmuyLZvhmUMmFDoRBFAadi1km59bjfF5J4d
         kWzkfEIo6Hyh8axepy05Q0Y0SukHwLD8Y5KSTFVXhwDfNAMU65YRWb91H4NB0tbBm1YZ
         /lXTng/W2mJRJ1Q/Wi2BdLzvpkQQ6oKyIgnKelSCPWF84hqCw0+9+1BojMj7gyxKItx7
         jPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Qr9BdbkkgkuLaABxg1maqPFbi8IH41Lo7L1VxAqiyw=;
        b=UQgxpSX2/ksMahDWtKYxowjGVAiiSMoBjx6gvvvZiXnhn/kH9kKsmmyAgqZHSRK9Ec
         L7B/xY7yqXtVPwCUjuZRr4rpOLLaI3K45bCtmizM1b5/iUDy9EcDzDFtfpFGCOxBxmRp
         /eKCacksq7K7szq4RK8mkvhaRnz8B2hcmAvWg/vJqdYuFi8DQ3zNkFK+F3egpYcCH4zK
         E5Y3wFYScU1Fg0b/Pmcm2gQr9L7XGevS2dxGjQpZCE19/G7VLe2NUSAvTLXHLeq65e4J
         h8WUtgW2KL1jG/ovV5uzkNmgkCK0iibxqQqcCh2jOHCt6AFGd2u1Sqf8vk5o8oKvpOUC
         7mFg==
X-Gm-Message-State: APjAAAXvCCNVcGMfaJrUDj770q32wYb0OEzM+scPpR1r85Xmn3HM1BWH
        G6hDK1LPgB9+AsKwXvcuo0v2ucelJUZ3xmdcxpca2w==
X-Google-Smtp-Source: APXvYqz9aT6DBqL1eSjmsf3APA52AKWR+11VI/tOJBRr1Zl3oa9tmU2n9K3uxQplpdd8BuXZX19EDE3gZHHtzgDtTcc=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr23654693ljg.168.1579793319446;
 Thu, 23 Jan 2020 07:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20200121161757.1498082-1-colin.king@canonical.com>
In-Reply-To: <20200121161757.1498082-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 16:28:28 +0100
Message-ID: <CACRpkdYzd13xu9ETj_a4eWrm4FMrVnF1NQ5G+=d_Ch=6SzRoxA@mail.gmail.com>
Subject: Re: [PATCH][next] iio: st_sensors: handle memory allocation failure
 to fix null pointer dereference
To:     Colin King <colin.king@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 21, 2020 at 5:18 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> A null pointer deference on pdata can occur if the allocation of
> pdata fails.  Fix this by adding a null pointer check and handle
> the -ENOMEM failure in the caller.
>
> Addresses-Coverity: ("Dereference null return value")

That's a weirdo tag, but I suppose you have aligned with the maintainers
about this.

> Fixes: 3ce85cc4fbb7 ("iio: st_sensors: get platform data from device tree")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
