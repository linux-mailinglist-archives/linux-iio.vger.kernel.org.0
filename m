Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D1018A014
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 17:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCRQAs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 12:00:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38327 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgCRQAr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 12:00:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id w3so11375153plz.5
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kRILFyuQsBDAWfLeUCI5AlZCl/hDy2YxD3lOyPa2++o=;
        b=dbtJtc65sWK3UJnaf6CzDNYr4zyQDSTbgTKKq28Sj/HjZMS3lPH+F+cAn3MW6yATcp
         6SUwYskYQ31uEyairesYaEWJx9JrovnNyKl97gEyMomwXtePmeysRqAsVj6lkSeZuuo/
         wvqBuJ4XrJp6O8KCemmwpCznPFfLacvxFJsy7MB3Oeq50Yx7G8OXHsyBIQYR5BWKMBRF
         g3gxvGpATuKjoUrZcDWNgsnynWfHmGJnljfu1QNj6GHsToZnbthfP2eopYZUtozH9dU3
         uvl7ZN4USV9mA5NO0kPexSILl3GR/BNrD0WAcYozXuN8JVggXn1K/XMpwtXoV2ORwXvf
         5uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kRILFyuQsBDAWfLeUCI5AlZCl/hDy2YxD3lOyPa2++o=;
        b=m9mBlEzTq6gWsf+MObCYLIeSD4VpquAQDVy3BGRzhtxumUp8raRxlLZ3pId5Yi6xWy
         nhY3cCh3ZZ9rCXoFB5U1/eCdTYkxX+H/QA0zarJlVtwv1UNAqDosV8ZvDK7DcVb8Arq1
         /T0w5dZyNlHDxQsHYA0/B3a/DGVgD3BTQ1R9D2f61RNdHi0u2BiFxGXmCe0mXGVc5ZSL
         75fPv2pe/moQUkLWjJKJyHukhF4N5SFAvHQ5hzEQBmcmqaFN9McTQc1KES7xK5qRkH3s
         kN6rn9AiKFEcJYhaK8VTJfUEa9iVrvecXZNaqBNNlW1lXkIis4GYgQoCY9cz04aGBdjZ
         uVAA==
X-Gm-Message-State: ANhLgQ1dPOYHs7cxAzz5LScnqun71YaRsuAPqNU75+CtOUjtAtQuSwOZ
        gL5iEounWB3OiGeznGkoATI=
X-Google-Smtp-Source: ADFU+vvio1wC31wVmg5b67kLCvFAeQSId8j02BxoPMkelo0Uyt9gcF7M76BH8nYm6SLdWOI20pIgzQ==
X-Received: by 2002:a17:90a:326f:: with SMTP id k102mr5226538pjb.48.1584547246164;
        Wed, 18 Mar 2020 09:00:46 -0700 (PDT)
Received: from SARKAR ([43.224.157.42])
        by smtp.gmail.com with ESMTPSA id nl7sm3276156pjb.36.2020.03.18.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:00:45 -0700 (PDT)
Message-ID: <5e7245ad.1c69fb81.4e6a8.b599@mx.google.com>
X-Google-Original-Message-ID: <20200318160041.GA10427@rohitsarkar5398@gmail.com>
Date:   Wed, 18 Mar 2020 21:30:41 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "alazar@startmail.com" <alazar@startmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: Add MAX1241 driver
References: <20200317201710.23180-1-alazar@startmail.com>
 <20200317201710.23180-2-alazar@startmail.com>
 <2964715e81108283d08258bcfa8420baef36737f.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2964715e81108283d08258bcfa8420baef36737f.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 06:50:41AM +0000, Ardelean, Alexandru wrote:
> On Tue, 2020-03-17 at 22:17 +0200, Alexandru Lazar wrote:
> > [External]
> > 
> > Add driver for the Maxim MAX1241 12-bit, single-channel ADC. The driver
> > includes support for this device's low-power operation mode.
> 
> hey,
> 
> overall looks good;
> 
> i'd run ./scripts/checpatch.pl on the patches a bit;
> you can run it on the patch file, or on the git commit with
> ./scripts/checpatch.pl -g <git-commits>
> 
> i usually do ./scripts/checpatch.pl -g HEAD~2.. [or something like that] before
> generating patches;
> i sometimes forget to do that;  
> 
Another good idea might be to set up a post-commit hook that runs
checkpatch for you! 

Reference: Git post-commit hooks section of https://kernelnewbies.org/FirstKernelPatch

Thanks,
Rohit
