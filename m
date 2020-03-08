Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7217D550
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 18:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgCHR7T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Mar 2020 13:59:19 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42543 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCHR7T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2020 13:59:19 -0400
Received: by mail-il1-f196.google.com with SMTP id x2so6606283ila.9
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2020 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CqnIXBKwcZ7eK7jSIB3TeSK6nKBkp//odaCbAVz4mrM=;
        b=OILKpkCVdg8fJb0oDu2UMkd8DzkoYGlQE0ZHzfYXS+P/oDPCnEJWEOoQSpbQ/FZ1pU
         s4w5LRDYWmrjH5UORCgcYMTdjCUFIipv44M0fIFyn8erlVwOT3VyLLqArSnayaUtbcZp
         rmhPMOQOjLRjvFH/qWU6BNz6pUhgNl05tREKTjJPCIuhHRigsXiaU6ssD+EcOBnYt6Oi
         /s9NNwUaOaPt2D2WVCIUk0FOKZqjwVyd7iR1wZ9GXPK3q5kRNyHREFc+o5LCABjrXODk
         gexACTfnFUMKORrBh/NrthZHFd7el7fN7dSUYJEn7UC3GvWsRxkEHH0Ca1bGkdKBQVM2
         tTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CqnIXBKwcZ7eK7jSIB3TeSK6nKBkp//odaCbAVz4mrM=;
        b=ma39jVNQn0j6Juu+UnCMfb13IQiJcPlG3PjnE3iMea/eNGRckCIE84KJyT1xQinHfB
         8dKvW9HBa6GCr8SOyGf4Z7caEGAGYAOxRW5kief0l/osDXu3QavhVXX8U6j5OB41Sibu
         c7L758xdb3CYnbpZBpIo+3cuhoXe08brIrOoGXKdTPcdx3msWP2QdavR9SQCUr+4phKr
         OOgGCHRRVosQ6SXX65EdOQU+msuCDpq4n3gkaDVjilcNAhl4mzZ+ZSCmeUJdIb1hRCRk
         fdAD+CwWZW1zx40I9k6lw29Qb2cdcTzAoThl4YjShI+U82zX9Pn8sTvHiQNqbZPnHqoi
         Qagw==
X-Gm-Message-State: ANhLgQ3aqw/XKjQphw5JTLtlmbrGSHmsN8GIXEPCL5TBSq8g2mmQ/3oV
        cp3THRL3N5J3Jt3CAM8tssKiPsfh8gAZc7RRkOUivjCi1JA=
X-Google-Smtp-Source: ADFU+vv543P2xAwcLKM9MTNCTIo21RVeWOWTYLKYntTFO48vO1ITYvWyJde7QMpPjSisz2LnrlmQXZrwV8Sv8gT5JuI=
X-Received: by 2002:a05:6e02:10d3:: with SMTP id s19mr5352844ilj.220.1583690357253;
 Sun, 08 Mar 2020 10:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200211131240.15853-1-brgl@bgdev.pl> <20200211131240.15853-4-brgl@bgdev.pl>
 <20200308135117.7c60c881@why>
In-Reply-To: <20200308135117.7c60c881@why>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 8 Mar 2020 18:59:06 +0100
Message-ID: <CAMRc=Me0AE7OgEVjiUfRUNODYoGj+LYy+1zGsGkXKput9AeKrA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] irq/domain: add a new callback to domain ops
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

niedz., 8 mar 2020 o 14:51 Marc Zyngier <maz@kernel.org> napisa=C5=82(a):
>
> On Tue, 11 Feb 2020 14:12:37 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the remove() callback to irq_domain_ops which can be used to
> > automatically dispose of any host data associated with the domain when
> > irq_domain_remove() is called.
>
> I have a hard time buying this. Whatever data that is associated to the
> domain is already owned known by whoever created the domain the first
> place.
>
> Since the expected use case is that whoever created the domain also
> destroys it, the caller is already in a position to do its own cleanup,
> and we don't need any of this.
>
> So please explain what you are trying to achieve here.
>

I'm mainly trying to remove irq_domain_remove_sim() and make it
possible to destroy the interrupt simulator domain with regular
irq_domain_remove(). If you prefer that we retain this routine as is,
I can limit this series to the first two patches, but I assumed the
fewer functions in the interface, the better. If you have a different
idea on how to do this - please let me know too.

Bartosz
