Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C41C56572C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 15:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiGDNbD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 09:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiGDNap (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 09:30:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8ACFCC
        for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2022 06:24:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u14so11109053ljh.2
        for <linux-iio@vger.kernel.org>; Mon, 04 Jul 2022 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=RNT9aO9JuvdHPRG7M+oG+iA92P02fztEckYlKzdbtWk=;
        b=mZ5i+hsuL8fdkpWGrhFFiNutnU2jOl0UmVPXtZ316je0d4PjS8jpMDpfZAbSIN+jew
         2EqogvZbpseX3msTfcBxwKaPrOjvpn0+Xf0Q4UhWMy75YuzHPVfttpYrAMcfewOxc/Z5
         MPVEyzmFOBqY7X48hLWOaKHpakETSRTypNUAwxQGOEt2Xeqo6ODssG3ojwj7nUQgi079
         78QgkQGDSOpqCfIWHQMeeOnWcfS/ghN3FyGnAVE6jyVzLdscqPB3xDoEZiXuRvc62TXF
         +NUI+ZvGKh0bsqvGZCJTanRIt7e+95vyYzDygokoZjbmLZRPhcRGQ/8FyFdXvke0+NXD
         g6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=RNT9aO9JuvdHPRG7M+oG+iA92P02fztEckYlKzdbtWk=;
        b=sJVG5toLUCzMG6vxxLCHlEj3+86856uDT9Th6h9UqLD2Ly4Xi8PQWtzjGAME4htToD
         1g6mIxEWZ0+h6hzjlz6N7Ko0N7+JaFTf1ft/h6pv2GmLALjjYEXaNbgEQNCirSf4yyog
         0QMX9q0Z7+23r/g5vwSVGpiVIq6tWVGIXp+Pvue8qSvw6euLDFmNVUU3+9bVatay/i44
         CYBTippvTPimzwITv/CawZF/DJdmIcAXQgomqpDjoM5EB6kFzj5pmC1yc5G/6fPPzue4
         VX3UJw+QQQyfJphHVaTRMQVGf7F7n1jDrZpNw0R65A+8H3tg1xYRDsEcL4dam5HDPiu0
         3xPg==
X-Gm-Message-State: AJIora+xNEiY8HkkD7P23caBtM05znmF9AF/6OXxKtTFEkRXRKF2mlNE
        Xj5gZZMO6LwoBnit7FSh8NoTrzL9MHMkFiv5paY=
X-Google-Smtp-Source: AGRyM1u9pMqpI7Uten85WU6kNbx9jlAlcks9tY+yNzZSgrOVIslz03Fea6vCNdTydUTc7ylYUrBZ0Tx3k26sFq7OD7w=
X-Received: by 2002:a2e:87d1:0:b0:25c:42b:28c0 with SMTP id
 v17-20020a2e87d1000000b0025c042b28c0mr10310076ljj.191.1656941080377; Mon, 04
 Jul 2022 06:24:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:2829:0:0:0:0 with HTTP; Mon, 4 Jul 2022 06:24:39
 -0700 (PDT)
Reply-To: nadagelassou@gmail.com
From:   Ms Nadage Lassou <maxigbikpi5@gmail.com>
Date:   Mon, 4 Jul 2022 07:24:39 -0600
Message-ID: <CA+2vrypbVJOVZOd9LAHR+F9J8qpbeMYsRF9GC9sa3j81OOJ7VQ@mail.gmail.com>
Subject: REPLY FOR DETAILS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [maxigbikpi5[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [maxigbikpi5[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Greetings.

I have a something important to tell you for your benefit,Reply back
to my email to have the details,
Thanks for your time and  Attention,

Ms Nadage Lassou
