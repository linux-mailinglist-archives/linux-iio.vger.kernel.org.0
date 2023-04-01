Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96E06D2C12
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 02:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjDAA0M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Mar 2023 20:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjDAA0M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2023 20:26:12 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7817F1D843
        for <linux-iio@vger.kernel.org>; Fri, 31 Mar 2023 17:26:11 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h14so11019721ilj.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Mar 2023 17:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680308771;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mk2nPyPDHF2nSoHYsdcPx4I1t1gE9idID2faOY4LJU=;
        b=m0ajyKWbiBsQi+yyaFeDz/LekS7o8eGnHuyLrqrWzF0DfDtB9TLUsx+koS0AjcxEl9
         n6JTDwucfctUVgPNSLqFa4LqbhZaSdqDYQTPHA9GxPgJcFRoL4ArKup34dd8wQz832Wu
         2isTIOo6nS/a0jcSJZbAVM+7vvjDJV+HXPXz8Vo5j538pJDsgWCCOANzDsA3ex0Fla8B
         rCRipNZkVZRX1K2FsMNhrWLFL8cwJhKaS5VgU2fRyZAVPtF88SV+maYua6tIqXYnW/8k
         iRyFeXM46PkemDKdV5BjQ1fdYL3uk1Z/rHU3c/RjxyjVpmaGB0f97v5AubCz0Ct6123w
         N+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680308771;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mk2nPyPDHF2nSoHYsdcPx4I1t1gE9idID2faOY4LJU=;
        b=3eRamK0Gtn+dkzzyjZspG9D+BRHBTnxSofWOub6wZiPdZ4k6X909hItVSgqqE2pvF7
         1Lkj2CKKIdfJTlSOxT++ADfegYHpyS5W34LqLjsliioyjnTxU4ovcGxU6LuBiqKni6Ej
         7BkyL1cHRZClleVDxZno1rLsoFT85GriVTStSNxTpoXRhS+1w35UqElUw90QBZWk86cr
         iNpuacN++UHFFfSnQoZWgkKmx0hxBP0r/z4+Ts0IfG17bSkCnKSCBarCDq5tYsE317jN
         OCvSmre0QcF/uVFayg5wQupfJPuouPaumw5MhxBRORwX6UVcewbmB9uENycDD0DQ0QAw
         MkyQ==
X-Gm-Message-State: AAQBX9celeOSIjHsWxx9AvpmmzKM5m+mVsyuIKmrW0KrH7Nx/xw1NnkN
        3EItqn5khw1IjVq0pkV1y/BW3qQ+fpKq6sOzSOY=
X-Google-Smtp-Source: AKy350aUUatv9USo+GLWE0R5Db4InEQ8FHyjW5YFVynnQRkX0fZbVcGyKJTRBVnZ/jP/LD9w0MOP2MoDjxBnl/ijkvE=
X-Received: by 2002:a92:cda3:0:b0:326:3f06:a0d7 with SMTP id
 g3-20020a92cda3000000b003263f06a0d7mr3672994ild.0.1680308770905; Fri, 31 Mar
 2023 17:26:10 -0700 (PDT)
MIME-Version: 1.0
Sender: samanpyabalo@gmail.com
Received: by 2002:a02:cf2d:0:b0:404:a526:7a9a with HTTP; Fri, 31 Mar 2023
 17:26:10 -0700 (PDT)
From:   Miss Katie <Katiehiggins302@gmail.com>
Date:   Sat, 1 Apr 2023 00:26:10 +0000
X-Google-Sender-Auth: WuRBnijy9fCcJAq2-UPWB2Q3aDM
Message-ID: <CAMbVUx65en446=mFMvR9m6P7orJE_Hs+Evm3ud1dZeSzmLDCmw@mail.gmail.com>
Subject: Re: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hej,

Modtog du min tidligere besked? Jeg kontaktede dig f=C3=B8r, men beskeden
kom ikke tilbage, s=C3=A5 jeg besluttede at skrive igen. Bekr=C3=A6ft venli=
gst,
om du modtager dette, s=C3=A5 jeg kan forts=C3=A6tte,

venter p=C3=A5 dit svar.

Med venlig hilsen
Fr=C3=B8ken Katie
