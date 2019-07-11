Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA23F6569C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2019 14:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfGKMQk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Jul 2019 08:16:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37396 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfGKMQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jul 2019 08:16:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so2682495pfa.4;
        Thu, 11 Jul 2019 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ebaI7JZoCfM256GUV8nZnCzT8goD+tJe0e6XvNMsOn4=;
        b=AAyusSQWWFQRi1vScJOtNT6zNZtyrWwvjH5sZArjCya6rXeigax5PS1E8fW0vvrwJ5
         s5n94IqdYgqTC3i8ufS4TvWsKjSBa8+CrQND8SDZf7z+XvViOrT/2BL+jXb2a3BBV3ka
         QsRfHH82Dj03jUVI5N4kJr5MegnMGbvpI7n3Ht8FExOTKEImAMuORGJbsm2nwWDNFBEX
         ufRM7ZPgwbthjeBjtDjCuixP/mVC2pkvaUYyvuC8ssgpEipmAB0IEZDB0eENVpgeySAp
         olFAf2sachkLqVqRLK1jT2+5eby7YuDLP6TRQrBAhAkIFaD1UhTL1daCTodxOErkwSqh
         0LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ebaI7JZoCfM256GUV8nZnCzT8goD+tJe0e6XvNMsOn4=;
        b=M9MTvr72MxGh3az8HQfRws6VJz7THB/xVb7z2qvQGBfMmq7VIcvd8KdWRnsx0jR97m
         IwZvWY0fewOYbwFF67qtuvvan2+X6m7R8vDbnVmSFRQslaHRxsHtRyfgz6FGM5Y5HaJB
         pBDnXuFfnI3Qw1hIn9Hv4oZZ2ziTyKBHswYHzfZoAurvKKUOHQWv2jvVp9Gz/gr/szCi
         TJ6oJ8xFEof7nN43Vtz55++pkd569B/C6wpewErsaIRO1Hvr44fNimcArSEuCzc/gjuu
         1FzStLZA8vnxdM23PBdVMt5arbpo0Kxl0ezyNaZg28kxcmmBarB8TYa5i5BPbry5UFBt
         gx0Q==
X-Gm-Message-State: APjAAAXicXsnPGXU+HVJGjRGd5XOIM3qQcqqkx5WFx6jZLiDUy7Caa5l
        YhqJDQ6RyiYx60+3NjMgloU=
X-Google-Smtp-Source: APXvYqzqzYQOKBq4miwPew8lzHQHfzU1AEc81YwR5rue/4y2BWib6z/bCeoGPD7v/JmU224bnamYjA==
X-Received: by 2002:a17:90a:cb8e:: with SMTP id a14mr4472521pju.124.1562847399177;
        Thu, 11 Jul 2019 05:16:39 -0700 (PDT)
Received: from icarus ([2001:268:c144:cf11:d03e:81be:e250:5da0])
        by smtp.gmail.com with ESMTPSA id a16sm5951841pfd.68.2019.07.11.05.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 05:16:38 -0700 (PDT)
Date:   Thu, 11 Jul 2019 21:16:20 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] IIO: stm32: Remove quadrature related functions from
 trigger driver
Message-ID: <20190711121620.GA11661@icarus>
References: <20190507091224.17781-1-benjamin.gaignard@st.com>
 <20190711115059.GA7778@icarus>
 <CA+M3ks42Whd=QVQ-4==n5bRJKEwYpQtRHs=gBGEZ_Hr=_8YU1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks42Whd=QVQ-4==n5bRJKEwYpQtRHs=gBGEZ_Hr=_8YU1g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 11, 2019 at 02:12:27PM +0200, Benjamin Gaignard wrote:
> Le jeu. 11 juil. 2019 à 13:51, William Breathitt Gray
> <vilhelm.gray@gmail.com> a écrit :
> >
> > On Tue, May 07, 2019 at 11:12:24AM +0200, Benjamin Gaignard wrote:
> > > Quadrature feature is now hosted on it own framework.
> > > Remove quadrature related code from stm32-trigger driver to avoid
> > > code duplication and simplify the ABI.
> > >
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >
> > What is the status of this patch? Are there any objections currently for
> > its inclusion?
> 
> You were the only one asking for more details about it :-)
> If you agree I think that Jonathan can merge it.
> 
> Benjamin
> >
> > William Breathitt Gray
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Yes, Jonathan please merge this if you have no objections, I hadn't
realized I was delaying it.

Thank you,

William Breathitt Gray
