Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA43B2D6E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhFXLQL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 07:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232227AbhFXLQK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jun 2021 07:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624533231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQbQQeIrRdDv283QxkkrMQqh6kQDdmhKMptxE1wKs5Q=;
        b=d+fX4qNGjIVjaLJiK5+MRR6ftmf+WLW32LA6IvvLh/o1kpE1W0t6zzDrJGjMSfzXTbePF3
        jnK5DqCyFp7mQQPTL/l4v5XjDwdaFK7IODBRWrgDiNIyQBzvHKaa9GLRChRsozLFX/GD9b
        Tkvpyoxntx+I6932sjiOjYjCc+wSfog=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-ubsZjiDoP9SqD8m-wJrEcw-1; Thu, 24 Jun 2021 07:13:49 -0400
X-MC-Unique: ubsZjiDoP9SqD8m-wJrEcw-1
Received: by mail-wr1-f72.google.com with SMTP id v9-20020a5d4a490000b029011a86baa40cso2070948wrs.7
        for <linux-iio@vger.kernel.org>; Thu, 24 Jun 2021 04:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GQbQQeIrRdDv283QxkkrMQqh6kQDdmhKMptxE1wKs5Q=;
        b=QGOpxQ15Ih/IyeJWqzX0IdTws7TNRTlsPEdzz6beBv/7uEpbMaLY5eXvAGJ3z8Y63U
         2THpnRP+COlBhb+HBn1Oz7bysE8dfRleFcjKrdf5IucsGkeiAryQjc4ciUnXyVQMiCwO
         VmsC1EoBDUq+tdAVj68c9j7aS7ItBGN80LhemZzFxltwjxF0t7OFBxR2PBHse7AwsT58
         Po7wyAxfrObjEgsBLdb6uib1lBiAX3BfwP6i74aiTLrMa7c2YrH2d+U1s8hSjuP8xdJV
         t1vPgXG8Zv1emD8FWvUo9y6TtXCKhaxs716le98Nvi9KsmncQOFn3+aVEESToBNiKN9j
         dDKQ==
X-Gm-Message-State: AOAM531OYk7xAwtDqNt4xqkCNtBc9B/LDxV5R9cmxY+whJqi5/p2S2W9
        yDIwg9k7beWZHU6BzFFgl3b5/+pT7sxfxtRZ+S78CysZXyBljw/2mhO3Gz9rqFRJZ+G/sKmMyib
        K941FxeOwLeYyPYRq29Hr
X-Received: by 2002:adf:a2d1:: with SMTP id t17mr3840774wra.74.1624533228386;
        Thu, 24 Jun 2021 04:13:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSnSI2gHRoJbdKSxlynk+kdGKf1GaZhZAlelWhFkUglT+nA21yQy20pZ9W2Ucqey8KT3Gh/Q==
X-Received: by 2002:adf:a2d1:: with SMTP id t17mr3840758wra.74.1624533228196;
        Thu, 24 Jun 2021 04:13:48 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f? ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id z3sm8173497wmi.29.2021.06.24.04.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 04:13:47 -0700 (PDT)
Message-ID: <3974817ea942f616b77450914aa23b181b062d87.camel@redhat.com>
Subject: Re: [PATCH] iio: chemical: atlas-sensor: Avoid using irq_work
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 24 Jun 2021 13:13:47 +0200
In-Reply-To: <CAHp75VcG-0L+qG5JirWH21bnpVwRv_wfjM6Sfd2pJrq4-OqJ0Q@mail.gmail.com>
References: <20210624100046.1037159-1-nsaenzju@redhat.com>
         <CAHp75VcG-0L+qG5JirWH21bnpVwRv_wfjM6Sfd2pJrq4-OqJ0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy, thanks for the review.

On Thu, 2021-06-24 at 13:39 +0300, Andy Shevchenko wrote:
> On Thu, Jun 24, 2021 at 1:01 PM Nicolas Saenz Julienne
> <nsaenzju@redhat.com> wrote:
> > 
> > The atlas sensor driver currently registers a threaded IRQ handler whose
> > sole responsibility is to trigger an irq_work which will in turn run
> > iio_trigger_poll() in IRQ context.
> > 
> > This seems overkill given the fact that there already was a opportunity
> 
> an opportunity

Thanks, noted.

> > @@ -474,7 +465,7 @@ static irqreturn_t atlas_interrupt_handler(int irq, void *private)
> >         struct iio_dev *indio_dev = private;
> >         struct atlas_data *data = iio_priv(indio_dev);
> > 
> > -       irq_work_queue(&data->work);
> > +       iio_trigger_poll(data->trig);
> 
> Have you considered dropping atlas_interrupt_trigger_ops() altogether?

Not really, but it makes sense as a separate patch. I'll take care of it.

> 
> >         if (client->irq > 0) {
> >                 /* interrupt pin toggles on new conversion */
> >                 ret = devm_request_threaded_irq(&client->dev, client->irq,
> 
> > -                               NULL, atlas_interrupt_handler,
> > +                               atlas_interrupt_handler, NULL,
> 
> So, you move it from threaded IRQ to be a hard IRQ handler (we have a
> separate call for this).

Noted.

> Can you guarantee that handling of those events will be fast enough?

Do you mean the events triggered in iio_trigger_poll()? If so the amount of
time spent in IRQ context is going to be the same regardless of whether it's
handled through atlas' IRQ or later in irq_work IPI (or softirq context on some
weird platforms).

-- 
Nicolás Sáenz

