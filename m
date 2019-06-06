Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204F5369CA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 04:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFFCGh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jun 2019 22:06:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42667 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfFFCGh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2019 22:06:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so315968lfh.9
        for <linux-iio@vger.kernel.org>; Wed, 05 Jun 2019 19:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88ECF44BWpL23s1dEr3eppcssIoU6JXyInAfcio0zoQ=;
        b=dNHrFF9iZ1C+q+eqDwyH3Y/mKptP033n2cjGq0Boy4k/jD+VX3QKwyHqAaW9p3JsEZ
         50z2rCcR2bD6pjdfuKzKW5goMhn/6XVS7tYWo0PoaHoIf0PX/yrQ3aCJgR+noLvcRfsE
         zf8WGDfMTB9PCNvDv17O6a2kAUCM+EU7nCNMHSrYsXgsbDfTPl3J3TF/XQxhsEh3Aijq
         e0Yh657rt/lWqH8mDLCvBM4qWlqgcdXWVrP2X+a6oMX2hqBeAbZMDKZ07by/W4wHN/IG
         hg2m3+FdOve4/kfa/rjAhCAVcupKX0Ewjq8DoCWUmROwNEciZz45voFO5gq3WTrxPVft
         yLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88ECF44BWpL23s1dEr3eppcssIoU6JXyInAfcio0zoQ=;
        b=sFd2oxohMEC6CAbx0p6xHscnBEuQXHYuvmJle4a7S7504zSt/piSG4iAstPbxcb5iS
         vxvjDixg2VhDa0RV8ITRstYS63XBpvI+soElcKLuy2KR//HFO94IGzxdazdFmtI15YUG
         Qx2LHQbyI6Fs/PHYupBAqv4djyRZT7u9uK4Jlgi2RL+QoKqJ3tuADt2P/KkrV81hF767
         Z9CAqTm30vUw3SaCKGKnrQ8KgE9+5B/43aoM8y8rEtywrBiXCzRYFG49iyfPKBNwiBEO
         dwgrvBd5vT3+AEE6V78zCWALvkQfWygfjROM1nPxcmIGiWvCWIT4DFeAzWZ7dgI3PEQd
         93xw==
X-Gm-Message-State: APjAAAVP8zg6gGusjY/CW0gVvg6uBfMS3Gxi6d1JJS9QU6nk+B0cChrU
        /AJ6Faz1IzRhy6HejlF5NkKKY7+eCP22v1iB9ys=
X-Google-Smtp-Source: APXvYqyjbFnmg3Yh4T/j1CFsWigkIHLOBA9P6N1LbgUNEXHZTZI3tonoM2Q14fno09rHRbTfw6vWQv+xUONyovDBaKY=
X-Received: by 2002:a19:5046:: with SMTP id z6mr22308952lfj.185.1559786795716;
 Wed, 05 Jun 2019 19:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190606014246.1850-1-festevam@gmail.com> <81b33d1f-0129-5fe4-9883-a9c30feafd9d@electromag.com.au>
In-Reply-To: <81b33d1f-0129-5fe4-9883-a9c30feafd9d@electromag.com.au>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Jun 2019 23:06:27 -0300
Message-ID: <CAOMZO5BkCFxLJS4ytrOmc5qw_Z83q_+1HpjDJ7hspA=ERUpGoA@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adt7316: Fix build errors when GPIOLIB is
 not set
To:     Phil Reid <preid@electromag.com.au>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Phil,

On Wed, Jun 5, 2019 at 10:59 PM Phil Reid <preid@electromag.com.au> wrote:

> >   #include <linux/gpio.h>
> This should be removed as well.
> See comment at top of linux/gpio.h

Good catch! Just sent a v2.

Thanks
