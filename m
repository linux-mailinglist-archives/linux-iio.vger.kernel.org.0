Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7C83EAA42
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhHLScF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Aug 2021 14:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbhHLScF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Aug 2021 14:32:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA00BC061756
        for <linux-iio@vger.kernel.org>; Thu, 12 Aug 2021 11:31:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bo18so11300690pjb.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Aug 2021 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EVASyczzs8xm9AxZ2mPSOz3HO10m9xGlkOMrpl69JoI=;
        b=rvEd0e1IMwxzqpHSVYBkM2uSYKwxGWF8EfimlQMgehwxPXy/KwBHQKWUfG7RhFlJYo
         1nw3JVxRsj10LXUMw8OamZZlmUFyzXnVqmUMbUPHkxzOqi6u1Zs55z2naJMZQfpzSK8L
         WoXa+S1SDgbk53n3IKPR5uG8VVf3Ib1dOUgFM9DR3LksKJ9o2QlT8fKPG+w6e6rL1saW
         CZfuShuN4ucqy6CLZyKJUsRrTEowkMiE55JR84OJqtGR1oc/QLlVnEe8b/Uw9PNaJN1u
         YVVCRsSAk9FAws6bwgKi1YTtf6AiCaKM3oBIOnzQHBwvi+sOwQRarhxWWdPh84SkKSEz
         hEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EVASyczzs8xm9AxZ2mPSOz3HO10m9xGlkOMrpl69JoI=;
        b=ZG8UwV4XwYOn9uZauAWppqTCrwMlVv1rszWIkIRmOBXA/d9odtzMd0tGhx2kn9Vld4
         nZ/a34d/5Vk0Qvb3HclxmKathmYShDo5SruXvqGQN3S/Z58J02Y9CwZLbIFEwmmoP/K5
         Zkp15MWCu5rjWmoC2rrBSLtNlJzXqPJW/wqKkiDGhczQMlDB/FLAYkJahnqF/P5pG1eR
         YbtMJR8wRNYhVj5Paj2Tc0G7mRBtKzjpP88W3nwHnvpadXv2UMUGVvlF1CNjZflFlwnY
         sA52iX0me/FKi8tDIHvRdpSr5nJepInS2XUno/l3D5HmvCoLi/KyqOB3ESnFQ3D7LTDG
         bsQQ==
X-Gm-Message-State: AOAM530CimeiY254z0EuN33wjcmAPp9I9NgWbbdxNNXtC7bSS6h495XX
        xFdk6obBSaUnisRA5QO49lOZIA==
X-Google-Smtp-Source: ABdhPJxMmzF6binYOlob6Gdnt7foCTQHzye6AC3pvuBI+VeaQO/bYKcu6QNXkWcgvgl4ba20ieW83g==
X-Received: by 2002:a05:6a00:23c5:b029:3e0:7350:efd6 with SMTP id g5-20020a056a0023c5b02903e07350efd6mr5398511pfc.40.1628793099479;
        Thu, 12 Aug 2021 11:31:39 -0700 (PDT)
Received: from x1 ([172.58.46.149])
        by smtp.gmail.com with ESMTPSA id 2sm4312977pfe.37.2021.08.12.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 11:31:38 -0700 (PDT)
Date:   Thu, 12 Aug 2021 11:31:35 -0700
From:   Drew Fustini <drew@pdp7.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: ltc2983: fix device probe
Message-ID: <20210812183135.GA3120809@x1>
References: <20210811133220.190264-1-nuno.sa@analog.com>
 <20210811133220.190264-2-nuno.sa@analog.com>
 <CAHp75Vfp_u9mbnUzcBXdv_RmFu9m4JK0=R5us6j3bquG4HzRvQ@mail.gmail.com>
 <PH0PR03MB6366AC51BA01533E28001A3F99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210812191919.00000217@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210812191919.00000217@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 12, 2021 at 07:19:19PM +0100, Jonathan Cameron wrote:
> On Thu, 12 Aug 2021 06:54:13 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> 
> > > -----Original Message-----
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Wednesday, August 11, 2021 6:15 PM
> > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > > <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Drew
> > > Fustini <drew@pdp7.com>
> > > Subject: Re: [PATCH v2 1/1] iio: ltc2983: fix device probe
> > > 
> > > [External]
> > > 
> > > On Wed, Aug 11, 2021 at 4:32 PM Nuno Sá <nuno.sa@analog.com>
> > > wrote:
> > > 
> > > Thanks for an update, my comments below.
> > > Depending on Jonathan's wishes it may or may not require a v3.
> > > If you address the minor issues I commented on, take mine
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >   
> > 
> > Thanks for reviewing... Yeah, I will wait for Jonathan's feedback before
> > sending a v3. It might be that he can apply your inputs when applying
> > the patch.
> 
> Patch looks sensible. I can make the tweaks whilst applying when I
> happen to be on the right computer.
> 
> Having glanced at the datasheet, I wonder if you ever had the
> reset pin wired up (and perhaps decided to drop that
> complexity later)?  The driver rather oddly
> include of_gpio.h and has no gpio accesses which makes me
> wonder ;)

I'm sure Nuno will have something to say but I wanted to mention that I
was initially thinking about this.  The reset pin is connected to a GPIO
on the Zynq-7000 on the custom board I am using.  I added that gpio line
as an active low gpio hog under the gpio controller node in the DTS and
that worked ok.  Though I had wondered whether there would ever be a
case in which the driver would want to reset the LTC2983.

Thanks,
Drew
