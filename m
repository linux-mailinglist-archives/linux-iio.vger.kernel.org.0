Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7E279A38
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgIZOz0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 10:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729186AbgIZOz0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 10:55:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B26B320882;
        Sat, 26 Sep 2020 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601132126;
        bh=5tMbBNIJtzVNaEG/loFu6mje1p8enh0WBS5iNeCs55k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qr4QpinhYLaSk7qWaLIGr9oO9V86HUNQag9yGWGGgY/WNln1XzTST+bRp1bEp90W5
         mEAZJk7HCwxTjk2KfaNzgDIawYUwqfndhcdwFL3nEEL5lwnhc/VFHNTdnB/LlDwQZ1
         LLah1bytFo+78NGbYdXzQXEJA05+jpl/5qyG6jB4=
Date:   Sat, 26 Sep 2020 15:55:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Tobias Jordan <kernel@cdqe.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: temperature: ltc2983: fix leak of device node
 iterator
Message-ID: <20200926155521.3b75342f@archlinux>
In-Reply-To: <b5eca237-b7ea-e4ca-3936-8c32892e49b5@web.de>
References: <b5eca237-b7ea-e4ca-3936-8c32892e49b5@web.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 26 Sep 2020 16:45:56 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> > Thought about adding an "goto err_of_node_put" instead, but as the error
> > paths are quite divergent, I'm not sure if that wouldn't complicate
> > things. =20
>=20
> Please add jump targets like =E2=80=9Ce_inval=E2=80=9D and =E2=80=9Cput_n=
ode=E2=80=9D so that a bit of
> common exception handling code can be better reused for this function imp=
lementation.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?id=3D7c7ec3226f5f33f9c050d85ec20f1841=
9c622ad6#n475

On this one I think readability would perhaps be hurt a little by
doing so, particular as we need to do the of_put_node in some but
not all non error paths. =20

It is a close run thing between the two options however.

I considered another option of suggesting factoring out this whole
per node block, but to do that we would have to do something a bit
odd with the return value as we have 3 options.
* error
* do not parse any more children.
* continue to parse children.

So I think in this case Tobias' solution is the best one available.

Thanks,

Jonathan

>=20
> Regards,
> Markus

