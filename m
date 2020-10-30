Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECBD2A07F6
	for <lists+linux-iio@lfdr.de>; Fri, 30 Oct 2020 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJ3OfH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Oct 2020 10:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgJ3OfH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Oct 2020 10:35:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42E2C0613D4;
        Fri, 30 Oct 2020 07:35:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so5450109pfa.9;
        Fri, 30 Oct 2020 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yn61Plqu8DosKmtbURIY5n3p9zI2gsP6LnQwK6jcMQE=;
        b=fdRqvJlsl8H82CBFcJB3jGpvah4+qaIsmEaDpV+N96MQFt4gkuKDPiTP8hBfPa5xW+
         KNTOedU3MIrs/Y18XSOJdHd/nYrEy1nJQnf5xsb6bu+RewfweNAITp3vrIJc3Bh0lbv/
         RfYiuZfKhfnBSc0JpAbdheW/7kBvAfZAuyTL3ixz3P48HNOzCMa8jEeHrUL+oyqPCWOs
         zmePLR8idSmmVAJNoe0UP+E+H4wwoVnk8Ivh7mfxQ7+/nh+pVa/xWjiYaThxttsqDKZr
         BUEMpexZb34JY4P2zsPAHfO7oTSKKEBrY7q6MUS+DtfW3aP0w9ROzMICLJpmsYS2ySTX
         1L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yn61Plqu8DosKmtbURIY5n3p9zI2gsP6LnQwK6jcMQE=;
        b=ZpGlAmB5OkBHWD9LPScj0ClBN7/ryokzPy31WWSNglblk7UymMa1yw3Iy59EtHwVpl
         /pi82pY2SAGtR3zfoKV1ctrz+B8pRXXOW5HM0mifGuSqHoII8x9qtu+lOXhyxWg+tDrM
         E454PbtmDL66FWAy4ObqpEdkp6bvjR+YLSq90D2Aiz5nuAMUcYinXGd1rZCkNXcXCNoL
         b2o1PqBo9/YYfNnLW3ItY3QByBRp0uNBvrsmWviFvPdNUQ0gT5VjRpQn0LFFDcoUKvzy
         xtTw1FHJlQEh2PZ7KLJp38fXEd4YpVmc+JFJag1ukBcRwTP6BhRPQWVO46gQnZOXekl4
         rEnQ==
X-Gm-Message-State: AOAM532AqlRx0qXWd0WNi5yhsSoyqA534WuIw+krPc76ZssQrx30Ei39
        4GsIGkJPgCz0JCMNzj01pnY=
X-Google-Smtp-Source: ABdhPJzfoWF5oEXYlfzln2y3269yOhZ+7XnbgadWlCsWbkkM2OhZkKZTS9+3lYjLVfPAmSDDq6+7MQ==
X-Received: by 2002:a63:c042:: with SMTP id z2mr2534669pgi.32.1604068505364;
        Fri, 30 Oct 2020 07:35:05 -0700 (PDT)
Received: from localhost ([240e:472:3d00:779:b01a:f9a7:6a68:30ac])
        by smtp.gmail.com with ESMTPSA id t17sm5816834pfg.169.2020.10.30.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:35:04 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Fri, 30 Oct 2020 22:34:10 +0800
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Message-ID: <20201030143410.pbixjo2cllhd27zp@Rk>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
 <20201029144007.77d967b0@archlinux>
 <CAHp75Vc829u6XPPA+eE=_AFZSPF+yVqT7nUXxtzkwx7-xLLrCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHp75Vc829u6XPPA+eE=_AFZSPF+yVqT7nUXxtzkwx7-xLLrCg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 29, 2020 at 07:06:40PM +0200, Andy Shevchenko wrote:
>On Thu, Oct 29, 2020 at 4:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
>> On Thu, 29 Oct 2020 15:48:56 +0800
>> Coiby Xu <coiby.xu@gmail.com> wrote:
>
>> Please put a cover letter on your next series explaining the context.
>> In this particular case some of the replies you have gotten are
>> general at it is a lot easier to find these sorts of things via
>> replying to the cover letter.
>
>Looking at the number of duplicate messages I would suggest that one
>needs to go through documentation on how to use git format-patch and
>git send-email.
>

Thank you for the suggestion! Actually it's a tree-wide change and it
seems the kernel community prefer individual patches or series for
subsystems having the same maintainer over a huge patch set so I wrote
some scripts to automate the process. That's why you see ~50 emails
with almost the same commit message. The only difference of these
commit messages is the name of PM macro.

>--
>With Best Regards,
>Andy Shevchenko

--
Best regards,
Coiby
