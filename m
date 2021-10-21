Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653494362ED
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhJUNan (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 09:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUNam (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 09:30:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF379C0613B9
        for <linux-iio@vger.kernel.org>; Thu, 21 Oct 2021 06:28:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m14so637538pfc.9
        for <linux-iio@vger.kernel.org>; Thu, 21 Oct 2021 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BKa7HEtV6lhYW+rhpHmPPE1qxY78ZTewDFg/eHB2DgE=;
        b=eUvEJlZKklhnU+qWEDL8M4q74/+DGj9k74WvJsbJDKVmeS7/1wninp5Rx4MJdZmCDa
         lAVy4UxhHBXd2DlIrKCIBuoazHfGfpOCBxH0XgENV4DFxobQ9HPoSzo8zR8OowcPxphr
         wqtl+q0Qr4F2wqFGMsBBOUHDWGK9qsRcRv7GNHlm7qJabVeUtccTKRc487pufcHgoCeC
         j1AFUAP6J0nriTM1kfqrhuonHt1y0adfWu5m8F8AjHtAmyXb5dt3oUgUEPOWrls8674p
         Rbrl5+EiaWQxXmWhs8xFCJXo4H3URGL/5SnGEAjZG/Erk8liSoGV7XBgmuQdYrqQ1WfN
         2MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BKa7HEtV6lhYW+rhpHmPPE1qxY78ZTewDFg/eHB2DgE=;
        b=gyBlsycc8PmAsjJIflmt02NiEoKSl2bKKPGL8pyhIHTsJpCAYSOMYtew7EjBXWbHzC
         N8fq27ykg4060JuqTGtgNguERkTRMVGIBPeQEd+0W+/gZWQDQjlzCb1YtNZBuJ0j7BNP
         c8harTaGbZX58SnrKn+TKquepUB3XHH4DshDkvuCK0iNO1yCy5eYFuuH31OPJ0m+6kls
         DTQJvqxSw/BNeXMaUyjSouZWUpByrWpjCizWT8tjgSVdSpM8VfjrvASkBUAG1amUsd2/
         W9BcymfEaQ15zkd0pwgimWePeX3GklB/Cr+BXe1nfXP/yUJmCgyLLdEgzYQqg8YZspxp
         /YSg==
X-Gm-Message-State: AOAM533gO9t9VukO/NjsYWsQVK2w8Q7VhKmSwqGnWNUr8Ehk/TMeBpdq
        YIw6ZsMik1y+bqWSfQnRg7XNAuNz5UEcWpTl6Tk=
X-Google-Smtp-Source: ABdhPJzQdCC2aVEEkfoCcrg+8qwnW0vqz5zomf23Fhm200VjJX1e4OYpUz1Ata4b13n+KQIvKzoDBmePVi+UBntoNzk=
X-Received: by 2002:a63:dc42:: with SMTP id f2mr4517016pgj.152.1634822906394;
 Thu, 21 Oct 2021 06:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211021121042.1372803-1-siyanteng@loongson.cn> <CAKv63uvBkC+n_1DBNwc9e+GoEGrEGKirAFgd6QxSnNYMMo0gMg@mail.gmail.com>
In-Reply-To: <CAKv63uvBkC+n_1DBNwc9e+GoEGrEGKirAFgd6QxSnNYMMo0gMg@mail.gmail.com>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Thu, 21 Oct 2021 21:28:15 +0800
Message-ID: <CAMU9jJrPhk-=BTgX+vHi2dkhNQeGjWNvFs9S4fr870JZaNHb9g@mail.gmail.com>
Subject: Re: [PATCH] iio/mlx90632: restyle mlx90632_calc_temp_object_iteration
To:     Crt Mori <cmo@melexis.com>
Cc:     Yanteng Si <siyanteng01@gmail.com>,
        Johnathan Iain Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Yanteng Si <siyanteng@loongson.cn>,
        Linux Iio <linux-iio@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Crt Mori <cmo@melexis.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8821=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Yanteng Si,
> Why did you limit yourself to restyling just one function in the whole dr=
iver?
Sorry, I'll restyle the whole driver next.
>
> If you decide that we should restyle the driver, then please separate
> the words with underscores to provide some more meaningful variable
> names because name of variable for calculated Ks coefficient for
> Temperature Object is kinda more meaningful than calcedksto without
> any split or capitalization. Same goes for Ha_customer and Hb_customer
> which are coefficients, capitalized in datasheet (hence retained
> capitalization in driver) and we want to maintain some sort of
> resemblance to the datasheet.
OK, Thanks!

>
> This patch is introducing a strange mix where coefficients from
> datasheet are capitalized, but local variables referencing/expanding
> them are not and all in just one function.
OK, I see. Thanks!

Thanks,
Yanteng
