Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D41E553497
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 16:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349021AbiFUOel (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349502AbiFUOek (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 10:34:40 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE21D0FB
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 07:34:39 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id c1so20237467qvi.11
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ay5LoB9rL6DKkaHE7LQdxRoCvU2YIiPHw0sfd4sxHkk=;
        b=jiQKoec+vV0AHTiv1Rsr9Jix5HSpCGWzcuQ/AxjQS1EN8kAVxAtq4eTG6hDVIKEB8E
         FOIorFVWTh5OBZ3CO7CU89bxYuQtAX62WtYcBU9Dt8JOv3va52VNWGWaIIhSIhr2jXYg
         TsTvGbQbnzNmQ3DpagmvlL4bAXE+MQ/3HNuMGL4oxIH7VJedILJ1s/nrmQ/+HmSz2Ea0
         AwfJVNeOtf0llvMl7aabJ6CHjl21SW6RHYnpSVR4VDP7w9eeZPpchirEQouc2ufR7s5Y
         NDJjOhKaO7VJUjrq/25n5QOiBodM5QClT63uNo0VsyBCwiVeUSkoUEd+K0GWswUMmnGy
         1+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ay5LoB9rL6DKkaHE7LQdxRoCvU2YIiPHw0sfd4sxHkk=;
        b=q5PVj0k4eWOvQgGS9jJrcOHiNSZjqwFy7IloSHnrWTCitoVjmU+9Rhykol4JNA/uTl
         4AdkEwZT3LHZFaGN+E1Dd1zVegeuIrV2iz6+UH5abZaF9pQp9x5J5FTpb7tlP+RsVM/t
         9u7io7K7g0xJFCEaAUxZ+Z0S/uUjKw/v6r7xCVYXhVjcRJMXS+AlBRgfFC03IEKy2pHo
         VIFp5Hv0lzX5CofDDy7I+5kQ2YGvQsB5WNBldNv1k3UhHuwIVes26GGsUXqDAtcV0+wU
         gq0APoDW7PjGCXAmYHbiOuLYUVj/QBxW+aNisqT0h41waBVPa5euA8JY6EveVKlvQEmR
         Ra/g==
X-Gm-Message-State: AJIora/18zmetfyjirKhTh5muQ3srewt5fR5TjrWVp/P3J8VsUTTxbas
        2Onh4xMHQjFMcCeyU8MJoO0=
X-Google-Smtp-Source: AGRyM1s+Zx3tyx0dz3xbh2WYiTtuLtNyZS3eacYuE+ruARn9aVHZUdDmUPP+tsiLRaazUJN6jQfFKw==
X-Received: by 2002:ac8:58cc:0:b0:305:1da9:7f5d with SMTP id u12-20020ac858cc000000b003051da97f5dmr24037520qta.345.1655822078865;
        Tue, 21 Jun 2022 07:34:38 -0700 (PDT)
Received: from spruce (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id x13-20020a05620a258d00b006ab935c1563sm10976206qko.8.2022.06.21.07.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 07:34:38 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:34:36 -0400
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/17] staging/iio: Clean up AD7746 CDC driver and
 move from staging.
Message-ID: <YrHW/F1gpCFN3tnX@spruce>
References: <20220619185839.1363503-1-jic23@kernel.org>
 <CAHp75VdjNuXeNPsjV4owGt5yg9N9kN8iYMKUX8rn=PRFpLKa+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdjNuXeNPsjV4owGt5yg9N9kN8iYMKUX8rn=PRFpLKa+A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 20, 2022 at 01:23:39AM +0200, Andy Shevchenko wrote:
> On Sun, Jun 19, 2022 at 8:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Vincent: I'm getting some instability with roadtest after forwards porting to
> > current mainline. Tests run 'sometimes'.  Other times I get a crash
> > in um_set_signal.  Seems unrelated to the test this series adds.
> >
> > Changes since v1: Thanks to Andy and Peter for reviews.
> > - Use sizeof(data) for be24 buffer data[3]
> > - Make the precision patch fall back to old maths if overflow would
> >   have occured.
> >
> > This started out as an experiment with Vincent Whitchurch's roadtest
> > testing framework [1] and that worked well so I carried on cleaning up the
> > driver.
> >
> > Mostly this is standard tidy up, move to new interfaces, then move the driver
> > out of staging, but there are a few other things in here.
> >
> > 1) Precision improvement for IIO_VAL_FRACTIONAL_LOG2.
> >    The ad7746 is a 24 bit sensor and this highlighted that 9 decimal
> >    places wasn't enough to keep the error introduced by
> >    _raw * _scale from growing too large over the whole range (I couldn't
> >    write a sensible test for it).  So I've proposed increasing the precision
> >    of the calculation used to provide the sysfs attributes with this value
> >    type and printing a few more decimal places (12), but only if overflow
> >    will not occur due to val[0] > ULLONG_MAX / PICO
> > 2) _inputoffset ABI addition.  This driver had an odd use of _offset for
> >    the case of differential channels that applied the offset to both
> >    of the differential pair (hence usespace shouldn't not apply it when
> 
> userspace?
> 

Also, there's a confusing double negative.  Either "should" or "should
not".

Thanks,
Joe
