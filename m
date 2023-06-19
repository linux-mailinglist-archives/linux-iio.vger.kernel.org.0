Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B543D735A07
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jun 2023 16:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjFSOrh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jun 2023 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjFSOrg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jun 2023 10:47:36 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7297123
        for <linux-iio@vger.kernel.org>; Mon, 19 Jun 2023 07:47:33 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id 6a1803df08f44-62fe1e6dc65so31844966d6.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Jun 2023 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687186053; x=1689778053;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvvzgSyIaiwvrxaKUb/eTlY+YgmAK8NNHPJ/p6FalJA=;
        b=qVOCYdYl3wsBSmsKg1K7B3Ee43k5l+RrXaCjGpWzMbU6WxCyFKP1KBsWkc2UZynifB
         xMOdVrBvgfuTjHby+yn86Saq2DlLs+T+8jKhjVeMFkZCLqraLDFqm4r9QLUKlag5WMTe
         ecPy5yJw/4H5xBRPJZ1ArN1NFEF1sk4VuwrKzA8ydR97qZrNOjm4BP7jqDTtg3giwfdf
         CXXXLvPQEqx77uW15kcq6DN7FJbaUbcujhUtaKB6AmAlZOvsiBmpHnIWNylUARnW6FzX
         C6z/DVECsPasr9LRgazFQMGa6p9a7RYTF6Ky9D+dTrq5sVgGNft55/zE/shn6rgqselP
         FaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687186053; x=1689778053;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvvzgSyIaiwvrxaKUb/eTlY+YgmAK8NNHPJ/p6FalJA=;
        b=dOF2Jpe9MXxOm/2Tco/BJFqPYrurPZnhtvPpmfpUQvWbdhcmDFe98hC4IjthiNmhkU
         6px53XjLPAMULkUHEtbfLiw+5Sr+2TxHSkHLDDuigJrfMeqnCb18SNazYLXB9+D83lHO
         4rFecD4a0zyIi329I8F21fa20a73jP2D4WmlEeydV/b/1XP7bxHJYkXrEFyEPvFkDZQG
         5ecUYfzdQeSJjY1yBDcdan0LxC+6vEn/H2N48jsU8nCpWVVj9kvhjQmJ3BdY15hVzUmu
         jwz7ucbmFu/jvKJDXwXDwZl9i4XSjsNM1Mkdy67sA4rV5NvG8jiOapVvbHfIGhH805Tp
         P3WQ==
X-Gm-Message-State: AC+VfDxiq8TOkeBGTmTzAFPXEjn76PwyxMdC8zcBfabwf2Q0v8IU9cL6
        t32tviSjr2TOHVrPGBiBs6NOe5Z7WcLK8nQs//w=
X-Google-Smtp-Source: ACHHUZ6HG45XGgrlTGDhKSV1cOlX04ILtXlm4hNmVgR0iNxC7NsmfOn27kDNLhFR8uN0cHYNi+9dIRS2G0pZWHERv7U=
X-Received: by 2002:a05:6214:d8d:b0:625:b67c:919c with SMTP id
 e13-20020a0562140d8d00b00625b67c919cmr11356871qve.21.1687186052692; Mon, 19
 Jun 2023 07:47:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:ef8b:0:b0:4fa:3e22:f795 with HTTP; Mon, 19 Jun 2023
 07:47:32 -0700 (PDT)
Reply-To: lucasmorefranklin90@gmail.com
From:   "Lucas M. Franklin" <brownvontavis2@gmail.com>
Date:   Mon, 19 Jun 2023 08:47:32 -0600
Message-ID: <CANXESi-WKzMw3BX46=3wQq2rBv9veaU=Q_LYoQ1be8NXv_Q6HQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f44 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9903]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lucasmorefranklin90[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [brownvontavis2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [brownvontavis2[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello
Did you recieve the email I sent to you earlier on?
Please, Kindly reply to me, thank you.
