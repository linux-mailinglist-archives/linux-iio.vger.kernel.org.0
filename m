Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311524C5B0F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Feb 2022 13:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiB0McE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Feb 2022 07:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiB0McE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Feb 2022 07:32:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236C15D66C;
        Sun, 27 Feb 2022 04:31:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B346AB80C6E;
        Sun, 27 Feb 2022 12:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8BFC340E9;
        Sun, 27 Feb 2022 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645965083;
        bh=NEoxQP7btFmqwLHAz4vA91rqiHkME2xrzGjWQgylmBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L+UWhSNd8Je3t6CUiFry7+mPRnfAUnLiUBV8ytOWYuRiqr0IEpqdfGwoWUwUdIbHb
         7K9pS+w8zDXoSRMNFuju+bpBuk20GNFY5DMlCu4av2ogASMXiSwqXnJEfksoU+SpdB
         Tnpi3B71ORH0wLJn3d/DeZjkJKBuBNkd+k05wFh9Ijg0jDO01DdBKGGQvrgk2QIAtf
         SUwRuPnSKnGCdHpWIXXuudfwuQV49yLbGoQtjnf+vHSarxWjtqMXoXGb3ev3EYn8PD
         AXLC0scLY31Su0BPFsxuVZhfqrxZOx16fnnv2VgssZt7XgD1LaDTkTC2L0tXC0W2Rc
         UKiZMwYwiwlag==
Date:   Sun, 27 Feb 2022 12:38:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v4 1/3] iio: dac: add support for ltc2688
Message-ID: <20220227123825.3555f44f@jic23-huawei>
In-Reply-To: <20220225130129.69-2-nuno.sa@analog.com>
References: <20220225130129.69-1-nuno.sa@analog.com>
        <20220225130129.69-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Feb 2022 14:01:27 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The LTC2688 is a 16 channel, 16 bit, +-15V DAC with an integrated
> precision reference. It is guaranteed monotonic and has built in
> rail-to-rail output buffers that can source or sink up to 20 mA.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Just one comment below - not a suggestion to change anything at this
stage though, just something that might come up in future.


...

> +static const char * const ltc2688_dither_phase[] =3D {
> +	"0", "1.5708", "3.14159", "4.71239",
> +};
> +

It if turns out we have in kernel users for this in the long run
we may need to change these over to numeric values, but we
can do that without changing the userspace ABI, so this is fine for
now.

...


Thanks,

Jonathan
