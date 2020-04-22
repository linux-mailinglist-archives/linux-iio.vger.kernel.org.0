Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1996E1B4D47
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 21:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgDVTZQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 15:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgDVTZQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 15:25:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9273C03C1A9;
        Wed, 22 Apr 2020 12:25:15 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so1600043pfw.13;
        Wed, 22 Apr 2020 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uj9s171jvFoitIg5Oada+VYi2BRzx4238j/iCXrZ1Ac=;
        b=R2IppJagLrK+ryuyiK45iVoThp1/7fgOnR3z4KrIzUwZu1rDqA44kra36HLdi5SSh6
         Zakfejh+fL1i2wJM8OleIPMjOB/ciAJbQVFTi2c3KKPun/NIbm+M+jqBJAC62GsSNuE6
         o+mfma/kTQh+13VUasKDCc1k7W+ZS1pRKR+rDhgZFnJOG/aYKsu57wYAtKaYvDMAdfI9
         9XKH3yjgAScv8t5Op4J/8EVxDw1oaA1fjkp33M4AgcUfYeWc7Fq0q1hg4uiAaLL5PBmy
         87w85tYUIf95QWGCSGeeXLXcj9xe0hciJj/XpphMfXNVbNaRgyoJ6SQWPUOQIvefGdBA
         diOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uj9s171jvFoitIg5Oada+VYi2BRzx4238j/iCXrZ1Ac=;
        b=sAef1FouCKeeHAYsDNUlbMyfKFdex4GSAsyzY7D4YauQOSDiuOw0TqvxCryIHxv8gi
         VeNZHmCQNJWcz7FPVqE7N1dWruS2Pq7tMbP+6CWZN5zenunSSnkEWso7ti8Xy+50eYas
         7AHLonr9iw3HqIbndzsROdmGDoylKxSA8Yb2fryI0rQqemb9EsLUuwBmgFJcjpr8y26d
         hqw2jyGRzLUmoHEGPaD0iDwc6vrHm2asbzVoEi7bO+f5nQNLcNwOnch8XfmC+W+TIUaq
         /WXT6nj5Hte47QsUU9tEuQS4APsOxY07s6Z4ruda07Jyjtef/BnJPtIVPkbYLJ4ps0m4
         pZfQ==
X-Gm-Message-State: AGi0PuaEb1a7peQMP1EOU6SZ8/GIlyByTYlsu6EJbEGW6rZhl+F95TD2
        y1zwLJ3SnertoDJ8jAuzYO78QVl/+WN9gC4gO0FR8Z45ix/+hQ==
X-Google-Smtp-Source: APiQypLk7oEoO4P2UL6Bp5lqa7linV94/uY192MJZRmUZKWU4eCwmc5qbgsAG9zIXt25afUutnQtpmDQGPlH/3mB8/0=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr572706pgb.203.1587583515291;
 Wed, 22 Apr 2020 12:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com> <20200422141135.86419-7-tomasz.duszynski@octakon.com>
In-Reply-To: <20200422141135.86419-7-tomasz.duszynski@octakon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Apr 2020 22:25:03 +0300
Message-ID: <CAHp75VeQComzEs0JmOBAqtKQ5Ez79sRHmsMNHiU9X2zWfnrpew@mail.gmail.com>
Subject: Re: [PATCH 6/6] MAINTAINERS: add myself as a SCD30 driver maintainer
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 5:23 PM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
>
> Add myself as a SCD30 driver maintainer.

> +SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
> +M:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
> +S:     Maintained
> +F:     drivers/iio/chemical/scd30.h
> +F:     drivers/iio/chemical/scd30_core.c
> +F:     drivers/iio/chemical/scd30_i2c.c
> +F:     drivers/iio/chemical/scd30_serial.c
> +F:     Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml

Broken order. Run
  scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order
to fix.

-- 
With Best Regards,
Andy Shevchenko
