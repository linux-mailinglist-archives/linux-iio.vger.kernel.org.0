Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366625EB22F
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 22:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIZUg6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 16:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIZUg4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 16:36:56 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E484E68
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 13:36:55 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-3454b0b1b6dso81224197b3.4
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=jvyeoRUNnnznxOtsERsSsNArG/hVWTuiyo6yAYsariI=;
        b=WsIpycyOpTqZNC0KXjOEqRpAon5DvI/6tYEa0DZfjjLdIa8KaRfj+lH7pqJRBF2e+N
         KOGZgC6CWQ8BuWPNC0QEZZSKOzS/A+z5Yiv+r3uHHxbvqzDVUIc9ymTGniGH2EhDviSj
         DlSZI4wdJIjJtMm8F7MHwH2Pffk21MxziH2GWygrmdKMLsYYvxF62VNVCoUQ+XU/8qBH
         BDag8fFsMu2VU13dJjtHlEbwbZX5o7y2xdTzgdeiNqhUJ9tlFOHLkzS0oxzPheFNNgGC
         o4kl/SvV6y3/5Pu2A05zWU59RxuFNOxxL2r8epZr4HbepG++nNakJdQzyVyAqMIiANjy
         bvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jvyeoRUNnnznxOtsERsSsNArG/hVWTuiyo6yAYsariI=;
        b=SaoRaitYCXQS8y86SgWx+x4eDvQHCVcgSU/PSAr+FIZn/8Nmt00zS5AvnvNva4FuG2
         A10krkO6cpBASdwjIrQkGfHbpJqpp9G178qDoOty7W8BJLk5y2hDR19eQazUf60Eo4Nw
         KUAjvXDPbPwR/kVF5IVN1so6/lwdkK+4Q/2wuKEzIuhumFOEbA0Oh1oW4fdpHdsDQGBm
         sGorqLLu+BVkHYaOJ7tUZ8ttwJ8lgIKfjurLeT5h6anYKTrtxnYIriYw9bTmKSs4SduX
         5w7sgFKtgiicSRnFEwaMofksClxlLpPbNOPN4KU633ZsZmPbdDjpM0wrMWt1CePsY5fn
         8YfQ==
X-Gm-Message-State: ACrzQf3AYFl2LN3BX/KCMaveBscl07Gzo+vb7uyrG/wlM43RtEPa681h
        8484fM8mqwYLRTCrUoFnudL2uPSCs5SifGo56KI=
X-Google-Smtp-Source: AMsMyM7arOUKMESubC2UF7TtFs5+t0vWyf+voiwGC6cB5EnyQcF+YMWk2/0mrMtnVPJN+p3ylzfEvIqJVqXmo9C4P2I=
X-Received: by 2002:a0d:cdc2:0:b0:34d:101b:53c with SMTP id
 p185-20020a0dcdc2000000b0034d101b053cmr22837511ywd.444.1664224614378; Mon, 26
 Sep 2022 13:36:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:a610:b0:306:28de:2ed2 with HTTP; Mon, 26 Sep 2022
 13:36:54 -0700 (PDT)
Reply-To: info.firstheritageloans@gmail.com
From:   Mario Buffon <jamesacarey988764@gmail.com>
Date:   Mon, 26 Sep 2022 22:36:54 +0200
Message-ID: <CAA8t2MJR_9peC4ZoZXQwV2hOORG+Z1MQMb_L6i+S8XZp5+K9-A@mail.gmail.com>
Subject: =?UTF-8?Q?Oferujemy_po=C5=BCyczki_z_oprocentowaniem_2=25?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FUZZY_CREDIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1142 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jamesacarey988764[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jamesacarey988764[at]gmail.com]
        *  1.7 FUZZY_CREDIT BODY: Attempt to obfuscate words in spam
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=20
Oferujemy po=C5=BCyczki z oprocentowaniem 2%.
Potrzebujesz po=C5=BCyczki na cele biznesowe lub prywatne?
Skontaktuj si=C4=99 z nami ju=C5=BC dzi=C5=9B, aby zapozna=C4=87 si=C4=99 z=
 naszym procesem
kredytowym dla firm.
info.firstheritageloans@gmail. com
WhatsApp: +1 (205) 852-6811

Jimmy Faltersack
