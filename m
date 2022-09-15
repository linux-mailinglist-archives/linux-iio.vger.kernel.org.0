Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E015B9FC9
	for <lists+linux-iio@lfdr.de>; Thu, 15 Sep 2022 18:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIOQmq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Sep 2022 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIOQmq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2022 12:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EFD6BD52
        for <linux-iio@vger.kernel.org>; Thu, 15 Sep 2022 09:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 977886254E
        for <linux-iio@vger.kernel.org>; Thu, 15 Sep 2022 16:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3A4C433D7;
        Thu, 15 Sep 2022 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663260164;
        bh=bL1Vq7XWaIAPzBn+oMNYqmyiZtmrZu/RAlAGBWx6XEA=;
        h=Date:From:To:Subject:From;
        b=b/L0qfSeh3aLaV6ZLjteamGlH/wrXdt5j/5ZadNyqfHy9ESD/OyjKXfXIovfkzKXW
         qOaLJH+rpTtFw6+UXlEUodXIQ5QuAfbwtX4YmMuHQqOUw2g06w49v3CH9dksVwPX9B
         ZMzjn7AT+6AEJYyqpYS6eXbYU4gpb0V1B8bfDTjvCW/1j5UUh4ezJuKSewvXbeR+5C
         cp7PEMLTb+aeFWs2VULNbWyrpfD/Zecmtb06vd84IAiokya9mDZzw1BQc8srYCH2RN
         lKKryjIS12EhVFVruKZ+8t3yxDqhQMm8KPCVcQmHD+0lfLB7sYUNNA+z1Gssdrg9h9
         wZs111jhx4QFA==
Date:   Thu, 15 Sep 2022 12:42:40 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] counter: First set of Counter fixes for 6.0-rc5
Message-ID: <YyNWADWgfl1sL10S@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0rj+3MOb39tt9UiT"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0rj+3MOb39tt9UiT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.0a

for you to fetch changes up to 8294b04153c33602e9c3dd21ac90c1e99bd0fdaf:

  counter: Realign counter_comp comment block to 80 characters (2022-09-11 11:45:02 -0400)

----------------------------------------------------------------
counter: First set of Counter fixes for 6.0-rc5

counter
 - Realign counter_comp comment block to 80 characters

104-quad-8
 - Fix skipped IRQ lines during events configuration

----------------------------------------------------------------
William Breathitt Gray (2):
      counter: 104-quad-8: Fix skipped IRQ lines during events configuration
      counter: Realign counter_comp comment block to 80 characters

 drivers/counter/104-quad-8.c |  6 +++---
 include/linux/counter.h      | 40 ++++++++++++++++++++--------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

--0rj+3MOb39tt9UiT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYyNWAAAKCRC1SFbKvhIj
K8NlAQDH5Lc+C+weLFiUsVPCg4PkuUS6ZaVhpuSgTSzZnEaUiAD+MuxOapcUlCOg
iJaIDK5y63oQxcqQNhfvmxnScUpXEAE=
=TZq1
-----END PGP SIGNATURE-----

--0rj+3MOb39tt9UiT--
