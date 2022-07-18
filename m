Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B372578BB9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 22:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiGRU17 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 16:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiGRU16 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 16:27:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BF92CCA6
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 13:27:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ss3so23385005ejc.11
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2fKOiLB/4ncWM89pkbpEE+0stdkEzUdEvtuMqaaW1Jc=;
        b=m8RrnMCRnKjZMNm/ULmtLlXD6mFE7Hua9ALJyYSPrrLSY2UDmNq141x5ID9NNrVou+
         eqXPsCKDwOidfAsIJT3Xx2ZwLqAYLCzNJ/41zA7Smi/Jpu5Abx2ttd8aD4n+ZqNr+BY2
         5LzOougURbeYMF/Sn4n7dXlO2Sbfa79nVZuZJP3ZIY6jOaMfeewkWBjqrgpIpJik2aeq
         rfrSXx5ovvci0X5VXToTir4SVZqf4dCBKzad0+C19BVMGiFer0V60raMJUmQIkQej5FO
         Dpg1QJ6j7enI+g8ZyibdXqrtyvs73ChwLo2Vn6ICfLDgiFDhIv0731BI+xgp6/TPiMVe
         50Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2fKOiLB/4ncWM89pkbpEE+0stdkEzUdEvtuMqaaW1Jc=;
        b=r6E49x6HOEImXcB0hhe7bBzM0JFzyaTk7HJCYdimhBfeO0aOTqbZJGK0RVIht9a4zV
         PsiJk5SiujrrsTSQvqOqJLBuJazqX6VRiB6iEY3gTcZ5snIPIlkMyfZBNFIuw4rwlZGY
         5uGBBF9NR3FgeLAWW+cUP2cr7RlA6uFJCEIUVBJkf1C9XC80jW/L7YXLsQ38rEfGTUF7
         ZLINwQxmMYiz/pTHqM/t3vnvfTtu2IEXJ36VhoxxLjHEApC/rujfj7JVirXsEKT4HOH7
         00ZNHicW+cb7picWSKlXnQzm//y1XpH+hxue/YjqRM5KKrMFe8eT7hmzipfKe3n7PS8v
         IU6w==
X-Gm-Message-State: AJIora+cMcOIS61bJLW8XEtPhoLAuKoxMzNxNVjTFw0fJfi0M7huzkk5
        HcBJxGfKDKquu+6gGrW4hKZBnROIP3c4oa8N3n0SP+jgWOfpJw==
X-Google-Smtp-Source: AGRyM1tyvHILc0RY8vkZb4oXslgzkm/koVlYEioF3EByInj6nv+jf5nxjcLcoHT5cLxmUjh2fjHKkDT67kreNbruw9c=
X-Received: by 2002:a17:907:2e0b:b0:72b:8720:487e with SMTP id
 ig11-20020a1709072e0b00b0072b8720487emr26491537ejc.102.1658176076202; Mon, 18
 Jul 2022 13:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220718194258.181738-1-ukleinek@debian.org> <20220718194258.181738-2-ukleinek@debian.org>
In-Reply-To: <20220718194258.181738-2-ukleinek@debian.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jul 2022 22:27:20 +0200
Message-ID: <CAHp75VfauFGXHuOGt0WkCmxK-cZRpAhC8yfckGzxB1d3fxK6dA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: humidity: dht11: Emit error messages for
 probe failures
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@debian.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 18, 2022 at 9:50 PM Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>=
 wrote:
>
> There are two exit points in the driver's probe function that fail
> silently. From a user perspective this is unsatisfactory because the
> device is unusable but there is no hint in the kernel log about the
> actual problem which makes it unnecessarily hard to fix the problem.
>
> Make use of dev_err_probe() to emit a problem indication which also does
> the right thing if requesting the gpio return -EPROBE_DEFER.

...

> +       ret =3D devm_iio_device_register(dev, iio);
> +       if (ret < 0)

Do we really need this ' < 0' part?

> +               return dev_err_probe(dev, ret, "Failed to register iio de=
vice\n");

--=20
With Best Regards,
Andy Shevchenko
