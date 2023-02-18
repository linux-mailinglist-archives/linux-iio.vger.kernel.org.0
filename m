Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46E969BA4E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 14:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBRNxN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 08:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRNxM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 08:53:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E268C4EEF
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 05:53:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B50960B4B
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 13:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBC4C433D2;
        Sat, 18 Feb 2023 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676728390;
        bh=7t1e56HOONX9Ekv5Tm0FwXuNJtD2TU3xDjWC/6jc2fQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lM1q8y+USlx10UAo9SnUNSqo3TvCUOrXWryF+7x0VvR5ZbxF2ENINGnzPIM977Jcp
         ItE2zklQPXolrZgAuzi3GrU6U19wtjShuAHYoZX+OvFKZcX2eNZxkQ0LLgH9CAps9m
         +HNvvnQR5zrNHaDG5MrZy5xK8v13GE/sI65/GKCSF1V39GhYcOC7Eymru8HnrCXJTA
         +k0KoD2fjPJNym3xKmu+HFrAP/ecdNGB4+vf/1Hwg4Wz/ghV66G1zeT6AAt32FI74E
         10oCBFJLyE4ro/bK0bb7dVDVwYAbntP3M/jOQtJvbMZn0aBGWDd+AP0AqcVxpupybw
         lBV1XIIOE/zZw==
Date:   Sat, 18 Feb 2023 14:07:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: buffer: correctly return bytes written in
 output buffers
Message-ID: <20230218140730.22c83e0d@jic23-huawei>
In-Reply-To: <2e2ea230-792f-1487-e6c1-ae5a88b63f11@metafoo.de>
References: <20230216101452.591805-1-nuno.sa@analog.com>
        <20230216101452.591805-2-nuno.sa@analog.com>
        <2e2ea230-792f-1487-e6c1-ae5a88b63f11@metafoo.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Feb 2023 05:40:46 -0800
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 2/16/23 02:14, Nuno S=C3=A1 wrote:
> > If for some reason 'rb->access->write()' does not write the full
> > requested data and the O_NONBLOCK is set, we would return 'n' to
> > userspace which is not really truth. Hence, let's return the number of
> > bytes we effectively wrote.
> >
> > Fixes: 9eeee3b0bf190 ("iio: Add output buffer support")
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
>=20
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

J
>=20
> > ---
> >   drivers/iio/industrialio-buffer.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-buffer.c
> > index 228598b82a2f..c56cf748fde1 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -220,7 +220,7 @@ static ssize_t iio_buffer_write(struct file *filp, =
const char __user *buf,
> >   	} while (ret =3D=3D 0);
> >   	remove_wait_queue(&rb->pollq, &wait);
> >  =20
> > -	return ret < 0 ? ret : n;
> > +	return ret < 0 ? ret : written;
> >   }
> >  =20
> >   /** =20
>=20
>=20

