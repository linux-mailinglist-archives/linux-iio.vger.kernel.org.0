Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D3869BA4F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 14:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBRNyW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 08:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRNyW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 08:54:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5B510244
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 05:54:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A210460B4B
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 13:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4970FC433EF;
        Sat, 18 Feb 2023 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676728459;
        bh=r7iVRK62pDBskRDM6CykaajOqjhXlbJquCZMx3Y2oTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sOjW1S8+KahI0W1BNz/msA0yTHYTJKY7+RhYTJSe8q83IRljGA9qbQ0a8CG6EbEvB
         r1ciVSGb9O4bUzVL5C6Q57f/kkTTDxBtYT8BuZtDxGvxcvPAa6H2wabS00hel49rKU
         jndLhxIbcXZim80YnI8sgNaOMQEcNclhcUT/2rTSdw1UO9MSQhGA3jupsEhkioYDpv
         wX/+LvCCJ6kc4OfKSuC1NdXJsOna5TA2JmdIeCq8EoHamUQavPpp5WNE+r7dWTUhh/
         KEC2f17AJ1hjcUH1elBw3fMtHj4sBm9VZCuDBF6f/8HpEDCLxkWcRwnAMhMYqnzmO4
         L1SvqTGq2c9cQ==
Date:   Sat, 18 Feb 2023 14:08:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: buffer: make sure O_NONBLOCK is respected
Message-ID: <20230218140839.5fac02d4@jic23-huawei>
In-Reply-To: <386610fc-08ce-ec04-a577-26f415b48701@metafoo.de>
References: <20230216101452.591805-1-nuno.sa@analog.com>
        <20230216101452.591805-3-nuno.sa@analog.com>
        <386610fc-08ce-ec04-a577-26f415b48701@metafoo.de>
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

On Thu, 16 Feb 2023 06:00:00 -0800
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 2/16/23 02:14, Nuno S=C3=A1 wrote:
> > For output buffers, there's no guarantee that the buffer won't be full
> > in the first iteration of the loop in which case we would block
> > independently of userspace passing O_NONBLOCK or not. Fix it by always
> > checking the flag before going to sleep.
> >
> > While at it (and as it's a bit related), refactored the loop so that the
> > stop condition is 'written !=3D n', i.e, run the loop until all data has
> > been copied into the IIO buffers. This makes the code a bit simpler.
> >
> > Fixes: 9eeee3b0bf190 ("iio: Add output buffer support")
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
>=20
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
>=20
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

