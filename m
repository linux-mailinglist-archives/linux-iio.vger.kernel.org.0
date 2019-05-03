Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769AB12652
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 04:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfECCen (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 May 2019 22:34:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32867 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfECCen (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 May 2019 22:34:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so2044119qtf.0;
        Thu, 02 May 2019 19:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHmi9Ibu7jtHY7PtCBhSSAF4IhbreLBAN5F0ptEmt0Q=;
        b=eZXn/viYgV0Bz0GiIC+p6VL57OA23zgu6ajWkL4MIXc6CGKKxuWsVv2tkoMcoJEnk/
         bI3SezCbRAg29i67UKQt63yrFF6E74Or+ROiiYT7CrJGt3hjIgLYM2T6EPQ1VvtYXmwU
         9Ll5yXUEoT/l8TvD7BhV6ur7X+1Ob0/QEA9wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHmi9Ibu7jtHY7PtCBhSSAF4IhbreLBAN5F0ptEmt0Q=;
        b=dCgDLiI1uMzZBIgyaEZQEmO/0nmU2l0/E9yJ5pLx7iBxfK5P0JvO2Kgyeoyjakambv
         0ueZu5MB/XuuVB2wMiNNwcRORZXkOz1qlAnN29ARQlTp4pukc9axlh06YsRs8yWDyRoM
         QNh8Tb5ZeG4oF14FYXUXqsECgcTin+P4WvAtBjCXhDOZSHEhJ4fsFhXXlDR3H88WdnoU
         gUzTGosEtjfgmV0+mRBJMIytbUxCR/buqWXwOu3CwCQNxx5zk7jUfbceY9eC/gsCQJNP
         oGtzxlBDRzgrSdxnHYv8sxR8uhRnwS8EpKLSO67LR7MRX4ceGIsRw73UbYW7YIfUcsvX
         /djg==
X-Gm-Message-State: APjAAAVJKJFLprchI4nPws9OXDMH73K/jeFf0rbXatvHfaUTHH7ePXb8
        DSFb8tCx5yP6n7gba15fGyh5X3FnwEJc4n5Ai24=
X-Google-Smtp-Source: APXvYqx5RxdF0dkmKrVJcM/FX5Hqq2lsUx2dPvDQpPCS0RCqtHLyQnKALRutFusuZJt3AyuF6JXPG1iWfe+c2Vj2JzM=
X-Received: by 2002:a0c:ac83:: with SMTP id m3mr6157405qvc.85.1556850881888;
 Thu, 02 May 2019 19:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <1556721787-28500-1-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1556721787-28500-1-git-send-email-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 3 May 2019 02:34:30 +0000
Message-ID: <CACPK8Xc2uwPwouto4Xg8fA0OAMJ3eP6kYjKcp9Bf4R90t1NdBg@mail.gmail.com>
Subject: Re: [PATCH] iio: dps310: Add pressure sensing capability
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Eddie,

On Wed, 1 May 2019 at 14:43, Eddie James <eajames@linux.ibm.com> wrote:
>
> The DPS310 supports measurement of pressure, so support that in the
> driver. Use background measurement like the temperature sensing and
> default to lowest precision and lowest measurement rate.

Upstream didn't accept my patch as they wanted it to support pressure
in addition to temperature first. I didn't ever get around to doing
that.

I suggest you send my original patch and device tree binding along
with this one as a series.

Cheers,

Joel
