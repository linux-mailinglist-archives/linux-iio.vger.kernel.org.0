Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2350918CA86
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 10:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgCTJjG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 05:39:06 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36525 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTJjG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 05:39:06 -0400
Received: by mail-il1-f194.google.com with SMTP id h3so4981666ils.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2020 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E88U8nR939B0wRa/2ymgo/wzYZwBbl5Itx+Xn0KyBCo=;
        b=IXvpJ9QsQUi2SmkShV+mL6C1EHO7bH5LxWIBM1iAg2RbAn8ltjzcw4k8Gzf/04fNE1
         Uz09MB8Di2p01C9jdQvKGQzPAgFVqEjbrjuWISi/TXKUyaXBfsRCWMGdH55TACtLJl+O
         +96zxdxSO4CAWHrvEDGVmRiVxp2voypd+cSClwkGZunY3rIDVCZtGqpnWx7L7KohbcFf
         xZZ9Gy37XGsOCPW3SZuopsdZ+4cCPQiYd8C4hfKP/HCW4kZsKY/E+ReGVxYn5sYxVyWu
         hzTnyxrceyk0Q1BtwD9bqeybfUslN3EoXiuVUHgq8b67XGEq+P5rnmZjJiAUtmm8lEVE
         Fb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E88U8nR939B0wRa/2ymgo/wzYZwBbl5Itx+Xn0KyBCo=;
        b=LBVOGFjW3XMCQ8+jgKiEMqfvoCodhNHemyefHh0EOsHRou9THg0wdFSu7L9Nhrzic7
         tTKxIWed7GpkrjX6vZKCppEYdhfpffBkcbcaIczdKN9d+tzjfCOJ9EQKrI9NNUcNqSKm
         nN6DJqybX2dbJVmkWOApisdICvUAE252jf+WMdWh1F4w20Cqlzh4lG7sv+e7nt+1jtom
         HwT6rr3p/rRfCJ7jQXyzw3Dn0zyr27WZrkOY946tdd2+nPLhw1Bd1Jv1kilcXvV5Lgy9
         gID3p1P9DtVVfjRnn0KsWQl9wpuVTrPe4Q2omtGpkgeLubjm2EySACmOWJl2e8V597UM
         DJ6A==
X-Gm-Message-State: ANhLgQ1qxI4XemtnxRbdOUEhXdZ80ZWAtkxHWbroKJAAXauXaO1MVMHs
        YlIofuY0/neKFcrphHMRYj3OCfFbwziwa82H37ikcQ==
X-Google-Smtp-Source: ADFU+vuJOtM9SWuAoICDi7FUXuv/yqWKoRjPj7ViO11UNp0s8DbPeKyoqfntqFUE6WiJzk8VQzzH4TeWJXiEYV2KR9A=
X-Received: by 2002:a92:d78c:: with SMTP id d12mr7307430iln.287.1584697145063;
 Fri, 20 Mar 2020 02:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200211131240.15853-1-brgl@bgdev.pl> <20200211131240.15853-4-brgl@bgdev.pl>
 <20200308135117.7c60c881@why> <CAMRc=Me0AE7OgEVjiUfRUNODYoGj+LYy+1zGsGkXKput9AeKrA@mail.gmail.com>
 <CAMRc=MdsQbm=L8sjJhnCcW+kb3UHHneSGqgCbTvWwsenCeMwxw@mail.gmail.com>
In-Reply-To: <CAMRc=MdsQbm=L8sjJhnCcW+kb3UHHneSGqgCbTvWwsenCeMwxw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 20 Mar 2020 10:38:54 +0100
Message-ID: <CAMRc=Me2EPpF99ZZL=FAKh+d4+tGxQU7b8bsJmzApAvkwKQ91Q@mail.gmail.com>
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

czw., 12 mar 2020 o 09:15 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
>
> niedz., 8 mar 2020 o 18:59 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
> >
> > niedz., 8 mar 2020 o 14:51 Marc Zyngier <maz@kernel.org> napisa=C5=82(a=
):
> > >
> > > On Tue, 11 Feb 2020 14:12:37 +0100
> > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Add the remove() callback to irq_domain_ops which can be used to
> > > > automatically dispose of any host data associated with the domain w=
hen
> > > > irq_domain_remove() is called.
> > >
> > > I have a hard time buying this. Whatever data that is associated to t=
he
> > > domain is already owned known by whoever created the domain the first
> > > place.
> > >
> > > Since the expected use case is that whoever created the domain also
> > > destroys it, the caller is already in a position to do its own cleanu=
p,
> > > and we don't need any of this.
> > >
> > > So please explain what you are trying to achieve here.
> > >
> >
> > I'm mainly trying to remove irq_domain_remove_sim() and make it
> > possible to destroy the interrupt simulator domain with regular
> > irq_domain_remove(). If you prefer that we retain this routine as is,
> > I can limit this series to the first two patches, but I assumed the
> > fewer functions in the interface, the better. If you have a different
> > idea on how to do this - please let me know too.
> >
> > Bartosz
>
> While this is being discussed - are the first two patches
> uncontroversial enough to make it into v5.7?
>
> Bartosz

Gentle ping after another week.

Bart
