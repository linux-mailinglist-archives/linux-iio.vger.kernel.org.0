Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1BD6C0370
	for <lists+linux-iio@lfdr.de>; Sun, 19 Mar 2023 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCSRVy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Mar 2023 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSRVx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2023 13:21:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C03F72AB
        for <linux-iio@vger.kernel.org>; Sun, 19 Mar 2023 10:21:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h8so10197142plf.10
        for <linux-iio@vger.kernel.org>; Sun, 19 Mar 2023 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679246512;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z0kd6DuT8gNgP7fGuNNblk7T6oFC/vCsnfu3Q4qzsEo=;
        b=aV8zB4rVxsR2QPnqGXDce8SapfxTsgzUnv9rRbJXbm+cWJOi70ljnuS3enEH4vPprE
         HySQWcMatdcTDtKEVnSehbcf/G80z15DZ53cuiAIeBDJmgErpj541oyE6lNfd5TmeR/G
         7ne7qGJZZxF6kpK02VFhFr/xfxJgxkI9/Jyx5oaVbsssrNbhMeJJWzwUa2xAl2lFNCRP
         skdFGvOCv0a9Juq99LgNJWyxenHzRul4sKbLY23YVrePOysykkKxQukFgqOUotV2zW4G
         roBHGhj4F9jDrHpU95IhUjK/b5F5uKnYkzacrmrA084TfkW4L8mzfFq/1WIyZQIdjRv1
         +72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679246512;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0kd6DuT8gNgP7fGuNNblk7T6oFC/vCsnfu3Q4qzsEo=;
        b=uUOQD4lz+pWjKHx+n62/e2h3+o34BGnRPVz/5FUDJ70q6OH/dEobEuSKfLrSRt8ooh
         N8CFS4CNfxqCLadI77sIAjAQKvPb75NFvigL2Hmpj2bShYnUG68GPEmAosLIntBtksG9
         foJRHN38i1gZkBrQChUYGUnfkf6qxFdcq0UH8WoW1+RDAE0++Ascg2VbpKmz6JHlzRnv
         oY6rv0rB90j2bOhGBzJWy4YlHLoIiZMmZwznMcl2v1i8Nw7EvcqdbpAvy/+AA8Juu6AR
         7Hy7fXOwScsGWQMk/h/MFyJiuN7fxDRVZCxZuHUMxw+bAXSVkEAkLaks/K4BfSeFfukT
         D7kw==
X-Gm-Message-State: AO0yUKVT08RhiqGImLYBcyGXxkboAiyNJckTwIbCTe+i/l2RIptDHVGN
        MQ8oight1fHhd4o+F6cqeVipoB6y6lFk1/AqeU4=
X-Google-Smtp-Source: AK7set8WdTDu/gVFocJKJNMe5WVB2MhmGQCpOxe6G9Zs3ujpZ+VgYAl7feG9PzrkDmbrVwkxFun5HR/U+TbUhGuhrHM=
X-Received: by 2002:a17:902:e54c:b0:19f:383f:65cb with SMTP id
 n12-20020a170902e54c00b0019f383f65cbmr5289766plf.10.1679246511537; Sun, 19
 Mar 2023 10:21:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:895:b0:5f1:f327:891 with HTTP; Sun, 19 Mar 2023
 10:21:50 -0700 (PDT)
Reply-To: fcr23893@gmail.com
From:   Daniel Ndoye <sportsjooh3@gmail.com>
Date:   Sun, 19 Mar 2023 17:21:50 +0000
Message-ID: <CAA4EzvD9GPPsd9gXhfb2xXWSAH0C1HymBjswX5Y5cs4tkO22qg@mail.gmail.com>
Subject: Providing All Necessary Legal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62a listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sportsjooh3[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sportsjooh3[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fcr23893[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

     I was assured that you=E2=80=99re very capable and honest to handle th=
e
magnitude of this transaction, If this proposal doesn=E2=80=99t interest yo=
u
kindly disregard this mail, but if it does make sense to you I=E2=80=99m op=
en
to do business with you in trust and sincerity. get back to me if you
are interested in more details. Please sent me your WhatsApp number in
your reply, Full Name and Address.
Occupation and Country of Origin.

Regards.
Daniel Ndoye,
