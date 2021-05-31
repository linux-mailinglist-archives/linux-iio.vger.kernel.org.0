Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB74395C86
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 15:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhEaNeA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhEaNb7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 May 2021 09:31:59 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F3C061243;
        Mon, 31 May 2021 06:23:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a15so7927302qta.0;
        Mon, 31 May 2021 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=I4OkV6HBXk8qI782g9fzNcEVp/vLpm7v/6N2vazlnC4=;
        b=N+FH0AXqd0+nJSWQA+Wc+pVJpjOc+9DSbVviIWaCBvC0R00Lu/cxhVqZSUxG/Iqfwh
         KYPn9HrvIkn5p2v4/SPzRbef+lGiSl/sVe6U6qzhOiuUMJdVk97fEhRBfps4zmQ0HXOu
         AS7DjcE++ZJUdbAvn1G1dcPP80IWqyVpoEiWQ2AAkccKjpa8B6mXBLFqoTaIGvzTYKjn
         kWwfBksI9n+oP7fwQrhhsCbPdp+QrJnU3xgisJ7KOxlVlRzqCDqwoSv8YO0zwOqClu8l
         zPwLDrbHR651G5s+tN2KbPFvV5T/DD2wJQeVibrf15dXdvPO6+07a2i+CE0qwROwgsP7
         CkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=I4OkV6HBXk8qI782g9fzNcEVp/vLpm7v/6N2vazlnC4=;
        b=ODMxhdMYhsMFqC8/nHzFCYixPFJIwXDq9F3JFCaafOKlTTCuG9ipunZW5xxroJLGQx
         4PuCOS63v3oFvK9/jIzuN8kEdbqs63AI5ZUyMOUyjlNC5esw2vx+rDVN+VqcPna6eFoX
         wwUJ7KKATXmY7FX5jUNcLDVidrsVxP5axN5uDbeN2xoFUFx87kAZEk+jA+ioDVN+y5x4
         fvU/z5W10IQb7+pMYWoKa6zlvb1DMaFbUoTsJUU6xYhMSlVf+TOpJTygD4W1tT4gEETs
         3TRT4+f+Jr6DIAXJZwgSMLAuK7p0fv87wBm1INR1SOSeNkAg4o58zKbzeZ4hgaIZmwmd
         ieBg==
X-Gm-Message-State: AOAM531JRpIHn1DpZECOQDxffn1zNo1SWOUQql6H5hfUiPwbutiC6o2q
        U8P3p8tRn/O9XJ61iBnV5Bo=
X-Google-Smtp-Source: ABdhPJxph8pYzSCAdR+SADQDOjDl0zZzaQ1fhe6hAH2tASmc1PIqA4O+iS7QnrSP+itH5xiuwp6Pyg==
X-Received: by 2002:ac8:594a:: with SMTP id 10mr14525884qtz.293.1622467398465;
        Mon, 31 May 2021 06:23:18 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id e18sm8356366qtm.73.2021.05.31.06.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 06:23:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 May 2021 09:23:16 -0400
Message-Id: <CBRGOW9627WA.72JM4KHL5Y84@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v1 3/9] iio: afe: rescale: use core to get processed
 value
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-4-liambeguin@gmail.com>
 <fb9bde38-6980-4241-6efe-fbad36dd8a2e@axentia.se>
In-Reply-To: <fb9bde38-6980-4241-6efe-fbad36dd8a2e@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Mon May 31, 2021 at 3:09 AM EDT, Peter Rosin wrote:
> Hi!
>
> Thanks for the patches. However, things have recently changed under your
> feet.
> Can you please adjust to
>
> https://patchwork.kernel.org/project/linux-iio/list/?series=3D484153
> https://lore.kernel.org/linux-iio/20210518190201.26657c49@jic23-huawei/T/=
#m0de421cc9f6bc10bfa2622d65be750aaced3810c
>
> and resend?

Thanks for pointing those out. I'll rebase on the latest -rc and resend.

Liam

>
> On 2021-05-30 02:59, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Make use of the IIO core to compute the source channel's processed
> > value. This reduces duplication and will facilitate the addition of
> > offsets in the iio-rescale driver.
>
> Cheers,
> Peter

