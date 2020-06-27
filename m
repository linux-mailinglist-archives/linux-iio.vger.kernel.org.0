Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5034420C2DC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgF0Px1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 11:53:27 -0400
Received: from mout.web.de ([217.72.192.78]:57895 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0Px1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 11:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593273167;
        bh=jBLarFFV68yP/ulxiShESeLYxTUIzO7337IHXE5BTEc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aStGqG0DX7WgCwmgAtu8frhJfnn9rXxvCYFwztsh8YIvyuJfdHootnZhIaIArQVph
         +pC5QfhXydtr52xeVdm/1uNCWH5EBeeO9N+w7gnXh8X10NDfJSHKIT8paQcS6O8Ad9
         5PLoDLtB5nLvukMHoPRN1cmvvdb+4ECet+DQMFe4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.65.31]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9IOj-1jiu8u0PqR-006MyB; Sat, 27
 Jun 2020 17:52:47 +0200
Subject: Re: [v2] iio: magnetometer: ak8974: Fix runtime PM imbalance on error
 in ak8974_probe()
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>, Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <dd84c12f-277d-27e7-3727-4592e530e4ed@web.de>
 <68225325-ba51-7aab-6fef-6f234f4068d1@web.de>
 <20200627155304.54ade781@archlinux>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8249fead-3a2c-f11e-eaef-e74c4c755f53@web.de>
Date:   Sat, 27 Jun 2020 17:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200627155304.54ade781@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KHrXvtUMk7XqUeSEdxdgLWbAOuBkzyazK+S2W03u7cmNHnpeAnW
 3RFKZSFvH9bFUX5XbrwkYkoYNW4xSPc9Yx0Ep/OFzlOXbaOL8w5sGhhUsBomoGy1O3Y3hF7
 rieAoCgzBGHme+SJcgX618KKt60CC0WUI5cZg7T8xqq4T5JvkWgcky/fOvr2IEB2npYmvS8
 pEnz//YcUZM2kQnveh7pA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SUVz35uRdVc=:dwcl63RMUru48LfelduSbt
 f9RS0B7qjuVbDFzOFZ98FznbxeRFOGNvcxIYRKJqqxLNsy71sRh97W45GsJTb511EPrwn+yKx
 K+ii0nVtN1nXqD8fV8HOPpWuNywFnghni3DOrx9EJ7OimDLu4vnIh7/ya93muMHasbo09kV6w
 y7N2GzKVbO/AVZ2LucRNOe7lk9aW1L+CdLFQkKYVszO24uSVwYdaAaOsGG7VWzV2UrzsVz8pC
 8oe++YE5R29+5u/QmRzuZ4p9Dc8sGe5eE8WrD4FEjRxAo0JIxRGEslqhWf3CUDeWyDAX9Z/GS
 GS+aYuZaR/iYxK+UzPSmv1eYr8aX/OLGeGhEA30r/7ckI58lYW3x5s+5w3bjfleEOd3c6NNvU
 Kkr1SGiSthYtTEMj3woV4EttWA/lF2C3CZU0CIqjcgn2C4Bht0HX9P4ViTsFa3+2h8sL3S/R9
 +8GMGS/UgshEK1AV3x/8VlsmG08Nz7cUYl9uBQJvuWUu+ZX4ddJEfvPs3NkWiETmGfFLYpC+t
 8hwryPwPVn+XCBcNh1XqEUDTtlYk1E10VftTgdUQG9UJzbS7XN6xNiG1cky20Z+v7K5UcF5DL
 SrWiQ09nAM0zxBqX/D65gmBjiqXTj3Da2nWb2lyGO39YVKxKR4491jsZx6nFrit6vgYI9CxrA
 E31inCItjCXlrxsN0Y96dTtm1d/ORPjC4BN+40Tak8y9orkDkpdcuGTGRzzxzWTmYHgleHAWG
 0B+zMPgg/Lrkm5qjvfUbICxKqP/sCVvF2oFteKgIo3QjeZr7+VEDwL19Ls1AuN/qHBq5T+9bi
 kg+yRa7NOAvuMxkErK6fW7zX8W4niXXaI2b5OMuUL2bAGnns9pmyUWK8wlrf9JiT5b/OuYjS4
 XRvptdA78wkF2qDrnVP1NmyroXXdtR8I4103Bm1OS2rAinx0pNaNv5NdBiAllreLCtO9UaD+L
 WaA/uiFQ8AvjM7cy1hRP+ztSq9BOWtrrXGefS5HTFlBgSoQZcBffAzKv+21mwhkc4qBoolJFa
 U3DArorwsEBQhNlqyvG+nHqETqw7iZHzDjyH8Qv+S1NExi05g62ttvMiVzy6jPFkwiZAv9lS+
 CcH1FTXtHjzW8NiSYs7kBdPOKnhgX18zmFV2lGPWVk7It2I3vQyE9APsG6KMEjrV34VJZBscQ
 BqSQ2dbXjDCxeTg8qbYQjchpL4n0NDai76te7zkor3OZ1rcqOKkHz6IckB02xdXCDtVZ+0dc7
 Qq7nVF/AbUys5bJAl
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>> How were the chances that my patch review comments would be taken
>> better into account?
>> https://lore.kernel.org/linux-iio/dd84c12f-277d-27e7-3727-4592e530e4ed@=
web.de/
>> https://lkml.org/lkml/2020/5/31/152
>
> I'm not sure why, but your reply did not have a reply-to field in the he=
ader
> as such my email client did not present it alongside the patch.

There are some factors involved for this undesirable effect.

Example:
My software selection contains open issues in the handling of mailto links
according to the communication interface =E2=80=9Cpublic inbox=E2=80=9D.


> Hence I missed it when applying.

Can my approach for a patch review reminder get more attention?


> Agreed it would have been nicer to have fixed those typos.

Thanks for this positive feedback.


> However, they don't affect comprehensibility of the message
> so I'm not that worried about having them in the log.

Can you get other concerns around the quality of commit messages?


Will it become more interesting to take another look at jump targets
for the exception handling?

Regards,
Markus
