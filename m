Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8F2D6A6E
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 21:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfJNT4s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 15:56:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36595 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfJNT4s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 15:56:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id k20so14781068oih.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2019 12:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9AZffw7ycKMcnNT4mxSNcyF9oJzwsLMXj04hF+yMcY=;
        b=qU5HKYAIBgPW/s43hrbvsNMjInhO3x72ZX80bqYe14vol2eF4gn2FCmvbC+acnc5GN
         rtFA+wPuGPSNu3rZz6eBWGLgYnujI3C1b2DhjG+C2FOBl72b34GKU+tOV8Eph223uCi8
         egN4GjNhGuP4zkWYL33m2MK1qZlFs5IVDekSb77Cz3X6VWrpI13RxxkvOhoNICJopU8S
         +iEXAYVrBs25k+CmJiSVa8mBUQdO8oLzbw692ZaStOJJ8Ev4YZeQI63RPyJNaX0Oj26X
         oI6j4FpZvTPEFQ38zkn6DxLjyCyx32C0b8bgVfWl8ozJzG9sZ/7MqU0s6V5mXaVjhuZX
         /yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9AZffw7ycKMcnNT4mxSNcyF9oJzwsLMXj04hF+yMcY=;
        b=cFrLQKKz3YzFWCqTUq8RQ7TUR7BfDGnFrRwVbg2YQd1KH8Ma9w8IyqfWhhFOycm0o5
         +f0Qn6jX78Q4lNDxV5YYpiw/Dsnjv9eziaZoNcYTM6PzLNNtbwgoZKmoy6NfMy61eq2Z
         4pziLUHwncaTqlyqooGeSw8QTHel3gUd9USLJsPxfU2J5LQYXQqliSnqPI60f3uqz8pw
         rsHD/emaeuJyBt6InPGjayb4SHypgVvF2d3iuNfllxeUBnArItFXambM4OhEqVd7OnLU
         9PK80YSN1kxfn37UGSWQhldGH/+x1OZ3CdzNt09QIBFvMvm/u+M3qlKh/EgPQ3Lou7yN
         qj7A==
X-Gm-Message-State: APjAAAVXGexqVuqgkhoe8m/TQ7h2aVTyRTD18mWzGYogRPju3IOX7TsV
        onFpcdgThjoThHDEeN9YDrnOBMKf+7dmMpTqAeI=
X-Google-Smtp-Source: APXvYqz0VbiSdTv+C+Bxg3IWuEOdWB4KNi7Kmug6UYBbANcncf6DHh1272GQWQb5Mk5UjXcqlM+KhgDa9FammakS14M=
X-Received: by 2002:aca:4155:: with SMTP id o82mr26320755oia.103.1571083007415;
 Mon, 14 Oct 2019 12:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191013164848.2069381-1-jic23@kernel.org>
In-Reply-To: <20191013164848.2069381-1-jic23@kernel.org>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 14 Oct 2019 15:56:36 -0400
Message-ID: <CAGngYiVPbgt1YTemHuBJ_oggd8RvfcmyUE5kapfSYCwTzNJmDw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: xilinix-xadc: use devm_platform_ioremap_resource
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manish Narani <manish.narani@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 13, 2019 at 12:50 PM <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Reduces local boilerplate.
> Suggested by coccinelle.
>  CHECK   drivers/iio/adc/xilinx-xadc-core.c
> drivers/iio/adc/xilinx-xadc-core.c:1184:1-11: WARNING: Use devm_platform_ioremap_resource for xadc -> base
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Manish Narani <manish.narani@xilinx.com>
> Cc: Sven Van Asbroeck <thesven73@gmail.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Looks good to me:

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
