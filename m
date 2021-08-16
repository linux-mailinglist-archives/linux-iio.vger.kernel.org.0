Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B893ECFF9
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 10:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhHPIJa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 04:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhHPIJ3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 04:09:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB165C061764;
        Mon, 16 Aug 2021 01:08:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so10633749pjz.0;
        Mon, 16 Aug 2021 01:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSmEDOlHPkeWDBRZsKIEYIy20P5Bumb1XzBEX9ztmHM=;
        b=p8k4w4hLeDEvIU4qu3SRcoToR2AJ/DRkNtydZvZVj+Jb9xt2ALCyvCxULROJQVseyn
         kibQS5SlQxlxEWYF+xrhh5eHTQrPLx28513UCtNO/eXrvFoTtiMtYDreHCcPcpNMCZSp
         oObch4R9F0zWKM6bbiZYJtFCbSlFQsh1b4YjtnsPDEMjG6OgbF7JfoPvJ6Xkmhi+X/Be
         VTP3S4uKajFIEoyVevbB24z6FJ1OP14vo3AI2GPmNMll4g1NQ+GnvR5Z2x7uoZtuSIOk
         DSwJOYGXRsnFV/p49La4w2oDfPMjVluYo7buRiUOadYarfve8+TuKi87240czfCCpG8T
         lqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSmEDOlHPkeWDBRZsKIEYIy20P5Bumb1XzBEX9ztmHM=;
        b=gQ8mvXUAkof/e0AlCYQM/XUP3NMgKdieKoZaBhzGuNiVccSihdg898OU/qUrjXNf+K
         4iTM2SHbZqKy5ZBFQLBYxhC1MAWEJBvTB5z4vel9078zgBnJN5VkmUX+Innlt+TaYClK
         C77EhEKpXPx812hHxVdhInPdnV06z7OA5iujwnpzfQKO0AZl8tT2uSxz+0NOGSxtTGEu
         auasER4hr1CA8jmdQE5XHaAGfy7CrHIN0XSzI9aykNDqt69F8HCAYpFehgjZbsK14zQ+
         NP5s/RNST5xO4B1DnreTH32C6eYyRoXBaKDD6NBG1R2P/WCtppmkRLgdxGj74h4nobe3
         oWJg==
X-Gm-Message-State: AOAM530I7tcBt7HITkqaGK06Ctq5O1tf12cIsLVJNel4HGBeXrlPTvM/
        G9vgHULWFasX5eZXNtWEVrrrIPjw13hxB4Yx6oQ=
X-Google-Smtp-Source: ABdhPJzPJoAW8ux5vVdeosHcEhbKSTLb5KV4/nIzzVNNZJKuYrNAt3MWbHSvmV6d/0FVtqJoNPl9EHmOF24jqxftOjQ=
X-Received: by 2002:aa7:9618:0:b0:3e2:1bc3:aa93 with SMTP id
 q24-20020aa79618000000b003e21bc3aa93mr1279192pfg.73.1629101338516; Mon, 16
 Aug 2021 01:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210815213309.2847711-1-liambeguin@gmail.com>
In-Reply-To: <20210815213309.2847711-1-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Aug 2021 11:08:19 +0300
Message-ID: <CAHp75VdOMg-7xX+KbdaDt5tduPhorujFwvpMPmdHKMVg=vj2Ew@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] AD7949 Fixes
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 16, 2021 at 12:35 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> While working on another series[1] I ran into issues where my SPI
> controller would fail to handle 14-bit and 16-bit SPI messages. This
> addresses that issue and adds support for selecting a different voltage
> reference source from the devicetree.
>
> v1 was base on a series[2] that seems to not have made it all the way,
> and was tested on an ad7689.
>
> v6 drops support for per channel vref selection.
> After switching the voltage reference, readings take a little while to
> stabilize, invalidating consecutive readings.
>
> This could've been addressed by adding more dummy cycles at the expense
> of speed, but discussing the issue with colleagues more involved in
> hardware design, it turns out these circuits are usually designed with a
> single vref in mind.
>
> [1] https://patchwork.kernel.org/project/linux-iio/list/?series=511545
> [2] https://patchwork.kernel.org/project/linux-iio/list/?series=116971&state=%2A&archive=both
>
> Changes since v5:
> - rename defines: s/AD7949_CFG_BIT_/AD7949_CFG_MASK_/g
> - rename AD7949_MASK_TOTAL to match other defines

> - make vref selection global instead of per channel, and update
>   dt-bindings

Same as per v5: is it a hardware limitation?
It's unclear to me what happened here.

> - reword commits 2/5, 3/5, and 4/5
> - move bits_per_word configuration to struct spi_device, and switch to
>   spi_{read,write}.

-- 
With Best Regards,
Andy Shevchenko
