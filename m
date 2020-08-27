Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7DC254FE2
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH0UPT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 16:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgH0UPT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Aug 2020 16:15:19 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9FB2084C
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2020 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598559318;
        bh=GKW0O0WZkkyf6n3xxfI4nqCXuHpLPnzGTBxJsnA+y98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dgCeHVvgmf+Rc2G+mcftp4Fq3zyacMjHFU3hP2ts65EDhf4vSKhdw+wbhuor2xnMI
         qRCPcDKB7ox+oN0Ngz9izYw+xcoVmeytcXz+4ISN66JIc0CkiFsPto0ZHixqy8vvz0
         f/N65zStcpED37pY9eRHVR+3ED/kSYBd/AKiCApA=
Received: by mail-ed1-f47.google.com with SMTP id v8so6050186edl.7
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2020 13:15:18 -0700 (PDT)
X-Gm-Message-State: AOAM5337bouoMpjIBKDTav4mKSXL7PyjKAREz2m6UDnZhH8NoF38SQpP
        34QQdqeRVDi/QFxPj9PYXo4RGSvgxkLVzfl9Iik=
X-Google-Smtp-Source: ABdhPJxoi9wpy+4U53C7HHaHxCKnoI1jBQe1soQVnyYTKwLPnLvtzHvTj8ItbxVmXEV1Lae3HlY3zTOyaX7ZkN9Wu38=
X-Received: by 2002:a50:d082:: with SMTP id v2mr21857227edd.348.1598559317018;
 Thu, 27 Aug 2020 13:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vdp194=twujCKqwLide7rE_y8_HYJRgEq+oD17M2hZGZA@mail.gmail.com>
In-Reply-To: <CAHp75Vdp194=twujCKqwLide7rE_y8_HYJRgEq+oD17M2hZGZA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 27 Aug 2020 22:15:05 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfHt6X+6LWUX67pHYvSPJRWUK_S92t2MtvGG68Yfa3N4Q@mail.gmail.com>
Message-ID: <CAJKOXPfHt6X+6LWUX67pHYvSPJRWUK_S92t2MtvGG68Yfa3N4Q@mail.gmail.com>
Subject: Re: Updating MAINTAINERS
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Aug 2020 at 21:58, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> Hi!
>
> Can we clean  up maintainers to avoid spammy bounces from
> knaack.h@gmx.net and others (like beniamin.bia@analog.com)? First one
> is really annoying (not only Krzysztof series).

Actually I did not notice because I already put all such analog emails
to spam folder. It's crazy.

I will send a patch removing Beniamin.

Best regards,
Krzysztof
