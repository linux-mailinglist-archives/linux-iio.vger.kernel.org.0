Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767754ED2B0
	for <lists+linux-iio@lfdr.de>; Thu, 31 Mar 2022 06:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiCaEIb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Mar 2022 00:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiCaEIT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Mar 2022 00:08:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BD2170D84
        for <linux-iio@vger.kernel.org>; Wed, 30 Mar 2022 20:57:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id c10so27016600ejs.13
        for <linux-iio@vger.kernel.org>; Wed, 30 Mar 2022 20:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DQEdIqJQMT2DTXxNnryD3JrAvawMTCRUVp7h3+Y4I58=;
        b=cc2rALVw1jxOK2Gb8L0J6Mph69Y5VA57JZQiuXcdW5z3m5d/DZa8hjTvhe9AMJD+oR
         sZWBxGtudQhCDz36qcCCNXc3ZsuQhTI5QG975d+QEmIL1cXJrOcVg13mjtJE8BHQS/S4
         iIpcrSGJc0jxFV9wD+VDOhUyo6n2rNmRzTngyO4v1oH9t0lTZGBvhB7L8IY+4CzZD6+5
         M4FqiJvek0gzYy5Td1KrRIVZHZrS0to+wXWFHnEmd210xrZ0KyIsMVxwUnRTdhYssOXv
         tEb6TOB/UOHofzCf3ePHP/RV74cESHbxnUZZk4LeNqIi36k63llzvcvq1RWBRsRe+fH3
         8SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DQEdIqJQMT2DTXxNnryD3JrAvawMTCRUVp7h3+Y4I58=;
        b=tZJJSoTNch74lU3HIzWPBIGgx+Uc7rFStseQ3Fz/CalJ1KwDTkdO948F6tx1zhmG/g
         PSHL30hDTaxRNnGr7T4gt4X2qofPveKuhKbgn5wfORStAdE4A7PaNCw2FzUFMBBHUOt9
         5YtkvFRXMMlsJYRdYNY4xNy9I+11x3CO1sUfqILZUbKe1k9l/HRICpSuRH9qesywol54
         hte0K6DzqCyJul6HPvHOOBf4Q6y7AYL8uDkvDd7Fq8ZFSBOhAQNpgk7untR+ZMdvw48W
         03NUaol8rUt64eKYWvWhgw3Skzi01tkS5FqVEOPonYccsS2/51OmqBIo+Al/bk6tQ0+x
         R9pg==
X-Gm-Message-State: AOAM530x4Eg0tN2JjyW3QRcmzut6KV5NtzeSrAoH96At5Qxc92FZGbF2
        hrIQ33SCln07B6rfKvyIkPKOHt6zoKbuKzjClvI=
X-Google-Smtp-Source: ABdhPJy14q49ndRpft22Zxx3hmPk1d7rlxFG+MTHM3G13eqOKVC53V7KmYGrVmRIuAapJFVzhRur/hctam12CatbZ+4=
X-Received: by 2002:a17:907:980d:b0:6d6:f910:513a with SMTP id
 ji13-20020a170907980d00b006d6f910513amr2951893ejc.643.1648699030251; Wed, 30
 Mar 2022 20:57:10 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Thu, 31 Mar 2022 04:57:06 +0100
Message-ID: <CAHpNFcPLqwMyzHt9F5WTGSHr8goaFcczEHS5YL7uajnhe3EwZw@mail.gmail.com>
Subject: Fast AMD, MIPS & RISC Instruction guidance in reference to https://lkml.org/lkml/2022/3/30/1565
To:     support.android@sfr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

RISC Instructions : What do they all mean ? Todays manuel BLTU

signed magnitude (BLT/BGE) or unsigned magnitude (BLTU/ BGEU) =E2=80=A2 12-=
bit
immediate encodes branch target address as a signed o=EF=AC=80set from PC, =
in
units of 16-bits (i.e., shiR leR by 1 then add to

https://passlab.github.io/CSE564/notes/lecture08_RISCV_Impl.pdf

#CryptoFASTintFL Polynomial ROOFLINING : In terms of Entropy pool Int
& Timer collections Polynomial is a Cryptologic_Functiontion & should
be A : Rooflined B : Streamlined & C : In Crypto_hash_function.h
https://lkml.org/lkml/2022/3/30/1313

https://lkml.org/lkml/2022/3/30/1565

Coding folder:
https://bit.ly/VESA_BT

Rupert S
*****

Polynomial ROOFLINING : #CryptoFASTintFL

In terms of Entropy pool Int & Timer collections Polynomial is a
Cryptologic_Functiontion & should be A : Rooflined B : Streamlined & C
: In Crypto_hash_function.h

https://lkml.org/lkml/2022/3/30/1313

**Reference**

Multi Bit load operations for bitmap,Texture & Other tasks +ON+HighLowOP (c=
)RS
May take higher or lower bit depth & precisions: Rupert S 2021

MultiBit Serial & Parallel execution conversion inline of N*Bit -+

2 16 Bit loads is 32Bit but takes 2 cycles...

16 Bit loads with 32 Bit Stores & Math unit:

Operation 1

16Bit , 16Bit , 16Bit , 16Bit Operation
    \         /    \         /
           Inline Store
     32Bit Store 32Bit Store
           64Bit Store
       \     /
32Bit ADD/DIV x 2 or 64Bit ADD/DIV x1

Operation 2

32Bit ADD/DIV x 2 or 64Bit ADD/DIV x1
          \            /
          4x 16Bit Store

4 x 16Bit Operation

MultiBit Serial & Parallel execution conversion inline of N*Bit -+

In the case of ADD -+ Signed for example:(c)RS
Plus & - Lines ADD or Subtract (Signed, Bit Depth Irrelevant)

Multiples of 16Bit works in place of 32Bit or 64Bit

V1: 16Bit Values composing a total 128Bit number
V2: 16Bit Values composing a total 128Bit number - (Value less than V1)
V3: Result
NBit: Bit Depth

4x16Bit operations in the same cycle >
If Value =3D 16Bit =3D Store
If Value =3D V3=3DBit =3D Store * NBit

Stored 128Bit RAM or if remainder =3D less > 4x16Bit -1-1-1 ; 16Bit Value S=
tore

*

*RAND OP Ubuntu

https://pollinate.n-helix.com/

(Rn1 *<>/ Rn2 *<>/ Rn3)

-+
VAR(+-) Var =3D Rn1 +- Rn8

(Rn5 *<>/ Rn6 *<>/ Rn7)

4 Samples over N * Sample 1 to 4

Input into pool 1 Low half -+
Input into pool 1 High half -+

*RAND OP Recycle It

*

(c)RS https://bit.ly/DJ_EQ
