Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB323CD650
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 16:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbhGSN1x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 09:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbhGSN1x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 09:27:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1FFC061762
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 06:33:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g8so24523058lfh.8
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXE01vhA2YBNs8+cOvqUgyYLYA05sje+2Hk/GGiPjNA=;
        b=l7DREebwW+zshErZMc4slc258/+LuiXEe4p05Iq5JE6Qu8rzzCM26qPQfHTY38o+H0
         g/4+yDreaIvLSKbKn7RqD94g1cktDMZ5ERW6G4PukAWTbnkv6xXOkvt/+lEdBlEjh3h/
         UVJwlGqnfvk84UkE6iNV0LtviTLcDj7ACY6zsUNKGCx+0CU++qg13utFaERdsmx1wvsR
         KzBmVYXkCuRqXeDG2zqIEMy3BtkHbrqilrnSDgp/vmb9Z/iI4cdFEH61RyD6SRnQS6kx
         KdepNYWb7N9ZZbo5x5wD2992W+jYFtScJiOsEeP3Z05nhzBB/+uwTNiSYe+beJiCTcvb
         PO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXE01vhA2YBNs8+cOvqUgyYLYA05sje+2Hk/GGiPjNA=;
        b=GK2FvoYuJ5O5V3KRhyBu0q2nqcv3OguwDF2LsC8QdJYuGlyoSJyNSIFzXgh+dCL+h8
         JtoOEdW4O7znYFapP5mx3xTBgEwGnajGoZzyYh0ljY3X1VEGbQMJHQd18Bqocl6w38Hy
         tdNjXLSi926qyDok2f8Qc9WV9HAczeGbPKhxuvQkW7ZAqlM9p8rLrgiuXrkuyDyEmIvJ
         WSzzL7TkPN4F4D88KFFNEo8sEg+1t8Im8lcatNWuSjUGYRFieBVU5iMDfJ3hy8aSdwBY
         eVBDTXM5G6oNQLnKf2qq/kNANYY2EgD70NzADJiVcr5E+NO2UbVg3+VwkoF/ICYZri9O
         9zrg==
X-Gm-Message-State: AOAM5325oCLZfJa/0aUxQ6QgAm+O7IifEXL/BOBk9PXoE7bTF3lgJ27V
        06SrrbCZdsQK1wZHYAwXTWL4wmtAHd/lgVUqUr7cTObqDUM=
X-Google-Smtp-Source: ABdhPJwCM0b4lokV59vxYMH/WVbo+JhrOqIuCVlyKIET6X5hBzAhV0cnXcVcE+SU5OYTZroYFNq7mzps99u8E7UDMdc=
X-Received: by 2002:a05:6512:b1d:: with SMTP id w29mr18313704lfu.291.1626703710159;
 Mon, 19 Jul 2021 07:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210719112156.27087-1-stephan@gerhold.net> <20210719112156.27087-5-stephan@gerhold.net>
In-Reply-To: <20210719112156.27087-5-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Jul 2021 16:08:19 +0200
Message-ID: <CACRpkdYaR=oyMuZjxDrmikB=1B3dZuy1rno_5SA9LfW3M_67dA@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: accel: bmc150: Add support for BMC156
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> BMC156 is another accelerometer that works just fine with the bmc150-accel
> driver. It's very similar to BMC150 (also a accelerometer+magnetometer
> combo) but with only one accelerometer interrupt pin. It would make sense
> if only INT1 was exposed but someone at Bosch was crazy and decided to only
> have an INT2 pin.
>
> Try to deal with this by making use of the INT2 support introduced
> in the previous commit and force using INT2 for BMC156. To detect
> that we need to bring up a simplified version of the previous type IDs.
>
> Note that unlike the type IDs removed in commit c06a6aba6835
> ("iio: accel: bmc150: Drop misleading/duplicate chip identifiers")
> here I only add one for the special case of BMC156. Everything else
> still happens by reading the CHIP_ID register since the chip type
> information often is not accurate in ACPI tables.
>
> Tested-by: Nikita Travkin <nikita@trvn.ru> # BMC156
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
