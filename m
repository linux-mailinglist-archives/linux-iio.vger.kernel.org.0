Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC895FEB28
	for <lists+linux-iio@lfdr.de>; Fri, 14 Oct 2022 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiJNIvH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Oct 2022 04:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJNIui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2022 04:50:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E119F8307D
        for <linux-iio@vger.kernel.org>; Fri, 14 Oct 2022 01:50:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c24so4129079pls.9
        for <linux-iio@vger.kernel.org>; Fri, 14 Oct 2022 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ng7mcmr4QJ6ZL7X9dSXkz6scbTE1whqwn58ZUV1v7fU=;
        b=bXSxrXLQJNlg99+2NOnArUr1YFn3aLsgPfKuPINthTv8KR4saVZuqJ9VAjE/ODjQnK
         QIaZ7HPRMDa7gllfxk19qwlCyJF85D09/qsBdo07gHH/AiQREbpEPEnJha25ObpKBTfz
         11FFfszPSeTPjmchvoixy2PedzpufGHr5P9d/xEKxoV9cDZ8JwSri6J5oloJghAF7/jN
         WgbrIHh5OF8CUNYeALXeqLW6JttcL2oWZutPQx046mQLhPRcp+fbd79JQRkku4Zskrpn
         Bs+VXEZ96IQ+8RBy1vbl7TB550am61+IOHfvqLnIBFuYkOFuMjmkSu02Eig8ejkg+RD7
         Raug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng7mcmr4QJ6ZL7X9dSXkz6scbTE1whqwn58ZUV1v7fU=;
        b=z5F2+PLgKYSoJPjdzrilbUo3Dp1g2iMsHWEEtjuFi0YCoB3ByYKZGgFisJcXUD+bgo
         UCL4FKnG8wvbS8me7vZ/foXVkaSVioU/niOcxpDPQM6K4aPLbtLzdESwY5GiHMbQCKbG
         7hlp14I+MLk3V8G3fXfLgeiNgmhXWAL7xEEv8sZ2loMcBUQSuylnP0rfdW3D2HwTZ4CV
         hComr8UHDgxHRT+PQdmeU2lnhffD7pfLenAI9vJe1dawxccPTG4paFXpsJ4+gkHNCig4
         DWff4Q/5KjzES7xSdw6cJqIaXOLgvJchOjxOcQPgr5BdNgrkffrOf5PYtWqrS3LY+nG+
         iejg==
X-Gm-Message-State: ACrzQf0DPrC9qyfO7xfbyWMInha6/8COlN7pd731hv0ZEYeOp2uYWKY4
        jVd1qjR1xAIC3BSdtLXyCfF7hf2mI+0IE5EVfZU=
X-Google-Smtp-Source: AMsMyM6hYtUPiazbTgTNPRgVW/dLuDQBFIMQshp1eIItdcSmphnXP9XPFwtM622AiOYjMkavgBYDWZ4y/uQ8zfDiQC4=
X-Received: by 2002:a17:902:bd46:b0:17e:8ee5:7b61 with SMTP id
 b6-20020a170902bd4600b0017e8ee57b61mr4416347plx.44.1665737410731; Fri, 14 Oct
 2022 01:50:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:48e:b0:2f5:1f00:a707 with HTTP; Fri, 14 Oct 2022
 01:50:10 -0700 (PDT)
Reply-To: stephenbord61@yahoo.com
From:   Stephen Bordeaux <baslealio.58@gmail.com>
Date:   Fri, 14 Oct 2022 09:50:10 +0100
Message-ID: <CADG+sOYa==fK1AnjQmK-12bZBkhwQVphe6myCPDZcU3sAzQ=4Q@mail.gmail.com>
Subject: =?UTF-8?B?TcWvxb5lIG8gdG8gcG/FvsOhZGF0?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:641 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4746]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [baslealio.58[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [stephenbord61[at]yahoo.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [baslealio.58[at]gmail.com]
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
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dobr=C3=BD den

Jsem Stephen Bordeaux, pr=C3=A1vn=C3=AD z=C3=A1stupce z advok=C3=A1tn=C3=AD=
 kancel=C3=A1=C5=99e Bordeaux.
Kontaktoval jsem v=C3=A1s ohledn=C4=9B poz=C5=AFstalosti fondu zesnul=C3=A9=
ho Dr. Edwin ve
v=C3=BD=C5=A1i 8,5 milionu dolar=C5=AF, kter=C3=A9 maj=C3=AD b=C3=BDt repat=
riov=C3=A1ny na v=C3=A1=C5=A1 =C3=BA=C4=8Det.
Nav=C3=ADc v t=C3=A9to transakci chci, abyste odpov=C4=9Bd=C4=9Bli d=C5=AFv=
=C4=9Brn=C4=9B.

Stephen Bordeaux
