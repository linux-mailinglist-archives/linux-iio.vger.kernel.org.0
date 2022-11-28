Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E438963AAC0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Nov 2022 15:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiK1OUN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Nov 2022 09:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiK1OUJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2022 09:20:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93117E0F
        for <linux-iio@vger.kernel.org>; Mon, 28 Nov 2022 06:20:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 661D4B80DB1
        for <linux-iio@vger.kernel.org>; Mon, 28 Nov 2022 14:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55660C433C1;
        Mon, 28 Nov 2022 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669645206;
        bh=oyqpWOaiVkx+e+6vnM/qK9oC5pzHHND6JkyXbSlE7IY=;
        h=Date:From:To:Subject:From;
        b=DqJOEzr2fVlgBrf/+cSQA2U8iLTUo61OSp781r9HQOjQ7nQo9RVtGaLQS+R/4yPhg
         FY07gpcZu3YuQiLjiauQqVdMACA2yAFsCTr6sB4mh8i66Mi2X+Pjxf+c9QaUvMNGkl
         nMoAvfjUWtz4FHuDTI7nyJqnoiBSMd/HUSf7KRsmGtjAfbh28FB1HqZl2l0iKduGBE
         Jx6XCEvqOvvUO/dQI+R0dUbY7srLiF+rWd9lOJVMUuwiIqlSWKUlmTnAYaZud9Pr2i
         ad9o2vGmetRP/gIjjh/ekP0eBuJpj5wNUpHBT77rWCnGDlXk+9VPo+s78SbCzbCNUw
         r4xrv3mOpIsvA==
Date:   Mon, 28 Nov 2022 09:20:02 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Second set of Counter fixes for 6.1
Message-ID: <Y4TDkoUSJchHFDLd@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WudLse6TOOb0+2Zx"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--WudLse6TOOb0+2Zx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.1b

for you to fetch changes up to fd5ac974fc25feed084c2d1599d0dddb4e0556bc:

  counter: stm32-lptimer-cnt: fix the check on arr and cmp registers update (2022-11-26 16:49:28 -0500)

----------------------------------------------------------------
Second set of Counter fixes for 6.1

One change for stm32-lptimer-cnt fixing a check on arr and cmp registers
update to ensure both registers are properly written before ending the
loop.

----------------------------------------------------------------
Fabrice Gasnier (1):
      counter: stm32-lptimer-cnt: fix the check on arr and cmp registers update

 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--WudLse6TOOb0+2Zx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY4TDkgAKCRC1SFbKvhIj
K/eMAQCk7UhpyHOD4B6t3Zsv/IkVO5tEnZQS9LnPhLdbvrVD5AD/U42zNT2blfkl
cmN08LyGQWnNyqTO0aa7awo1l96VzwE=
=5j0W
-----END PGP SIGNATURE-----

--WudLse6TOOb0+2Zx--
