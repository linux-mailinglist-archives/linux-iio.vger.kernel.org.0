Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF84CD77C
	for <lists+linux-iio@lfdr.de>; Fri,  4 Mar 2022 16:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbiCDPQX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Mar 2022 10:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiCDPQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2022 10:16:22 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1631C3D1D
        for <linux-iio@vger.kernel.org>; Fri,  4 Mar 2022 07:15:34 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id t69so2094674vkc.5
        for <linux-iio@vger.kernel.org>; Fri, 04 Mar 2022 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=OZxDF/kMvJsP4MaNdbgNx1aepcIHBOd79TgMIYQ76DE=;
        b=Vxg9aRwkExWF6qWZx+igm+n3OJWIAJ6Ggl2dTHTEoXqzdMnmUHmonR7/fPkrTQ1FqS
         CL9NveHehC1yFyneqxxe1T+8vjQ0SmYJQUFNX+1wAkq+y+I3he1emk1Ezp0B22mjDmSz
         LYlRlnQRiQZghKJrw3Wl+SPdnBBYLXkTIsCsoNMnkEuEo4jOvUGbLJJ64IuxeViBB++E
         rtW0TmNUlriC7bHJiVzv0klGQIleIq/hLVE9aq2nPBYU+YLnMacmkCbYn/AMqv5S5H7x
         Ti0BdxJyY07ddsELbBdoi6Hxr+Qyj7/DCtFtnL3GQZjD0rQ6x+rIHFVz9yNDRhvIk3ps
         FIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=OZxDF/kMvJsP4MaNdbgNx1aepcIHBOd79TgMIYQ76DE=;
        b=DVppBIaoBE3dNKbUgkhH5UR7pJ+kFCyJiLVIWpUKgLX5ZwGkJoND7EGh6cnXMZ/tWZ
         IGhKPhhDW6n+vRdsBPFTlDXoonA1rOZw+vWKAkTyN+ecGu+ET02idLn2WZWdD5XCiiED
         lsgEnngpWXs8KnVHfAujJgNjKa9dmeVzW2N0ypJF8R+HXgdRAHGVIzxepCnnFpvJLtef
         7QvtMQr/mqhZDqs+2N5r9ccFG6Dsq7ZHqgDMFTnq+ninvZYxe0BZUzguU8DVazO121Ex
         ZURUl7IRtQkTP6da3XJ14nEuFEtym530gSC1W6EYp+zRt/yaoAkB+Ss2L0Yz0/vaBajG
         vdSw==
X-Gm-Message-State: AOAM531Pbz4HNyMSvqC3ADOQIU/YOnwUCDp6j2a/iz+RgaWF1SydcLFp
        Xa21l66qsqITCacIEVKLxd5uJbuHi/Vgbb61
X-Google-Smtp-Source: ABdhPJwboZkEWv4OZIdcsywhYL+bgtN4GZltIzRlcbYCDgSLxDjpdOsdpycjU78h+odsBQ0GHQowXA==
X-Received: by 2002:a05:6122:1687:b0:32d:a9a1:5abf with SMTP id 7-20020a056122168700b0032da9a15abfmr17444943vkl.30.1646406933788;
        Fri, 04 Mar 2022 07:15:33 -0800 (PST)
Received: from ishi (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id e21-20020ab031d5000000b0033ffa5785cfsm882296uan.16.2022.03.04.07.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:15:33 -0800 (PST)
Date:   Fri, 4 Mar 2022 10:15:31 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Counter updates, cleanups, and features for 5.18
Message-ID: <YiItE3YONnTILC9Q@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j/5n4095wgT8gmF3"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--j/5n4095wgT8gmF3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  https://gitlab.com/vilhelmgray/counter.git tags/counter-for-5.18a

for you to fetch changes up to b98d1a3ed4b0b324b261b23defd1bdddddba4d44:

  counter: add defaults to switch-statements (2022-03-04 09:30:38 -0500)

----------------------------------------------------------------
First set of new Counter updates, cleanups, and features for 5.18

Only a few changes this cycle, but we do see the addition of a new
COUNTER_EVENT_CHANGE_OF_STATE event type that allows userspace to watch
counter pulses.

Features
* Add new COUNTER_EVENT_CHANGE_OF_STATE. This adds new counter event to
  notify user space about every new counter pulse. The interrupt-cnt
  driver is the first to use this new feature.

Cleanups
- Add Counter subsystem git tree to MAINTAINERS file.
- Set counter device name. This provides a convenient way to identify
  the counter device in devres_log events and similar situations.
- Add defaults to switch-statements. This pacifies warning messages from
  Clang static analysis reports.

Driver Updates
* 104-quad-8
  - Add COMPILE_TEST depends
* interrupt-cnt
  - Add counter_push_event()

----------------------------------------------------------------
Oleksij Rempel (2):
      counter: add new COUNTER_EVENT_CHANGE_OF_STATE
      counter: interrupt-cnt: add counter_push_event()

Tom Rix (1):
      counter: add defaults to switch-statements

William Breathitt Gray (3):
      counter: 104-quad-8: Add COMPILE_TEST depends
      counter: Set counter device name
      MAINTAINERS: Add Counter subsystem git tree

 MAINTAINERS                      |  1 +
 drivers/counter/Kconfig          |  2 +-
 drivers/counter/counter-chrdev.c |  4 ++++
 drivers/counter/counter-core.c   | 12 +++++++++++-
 drivers/counter/interrupt-cnt.c  |  7 +++++--
 include/uapi/linux/counter.h     |  2 ++
 6 files changed, 24 insertions(+), 4 deletions(-)

--j/5n4095wgT8gmF3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEESdocE8T8CMGLP5oTJYqFfHOePQsFAmIiLP0ACgkQJYqFfHOe
PQshAQgAiqrVtXAj4ln/IAHAWUMZqy/TkL+FkDQDL5ONnw0mNMohqH2rGNlrcosw
aYImK7AEQyI9M4SHtfxenIH7SqTBUgo35pIzwcNNwBQV+aGxSWUn3NaFie23D4kI
AEixkkFqHSWbSwCBlEQCTrTyclON32MYAKIsjcjMaMhKRdDOXpOp1NoxBjRL0To2
i3kdxnQ02jmdkkJrJKHlmo2/uO5lECmP9Vc0POST5gTkqIUumEnBFyp8n2hSbMIW
VdVkc2X7OzSCF8KVuVxoDZt6TWUB7Mp1KW/On3ENMC61GPm80wTHrPE0VGDLlqA9
4dgrSXrpTc/icQYSt8f6I6fQrSTjTw==
=cbop
-----END PGP SIGNATURE-----

--j/5n4095wgT8gmF3--
