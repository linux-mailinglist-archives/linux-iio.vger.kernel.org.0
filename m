Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6969B757
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 02:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBRBMZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 20:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRBMY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 20:12:24 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63BE457E9
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 17:12:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id er25so10464561edb.6
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 17:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30mLK80vSZcSwBOrdpYOKvqdrdKJjCkQDSG3S0CWQyQ=;
        b=MnDiTV7YqfJG7nhRoqkbQGx4A19COxj5PMkdR4zL6nWhWcySg7VhCiF8vSchNnbygE
         f7Sn4/Rwg1zi1isLgfS9Aj8XalDeiG5pS0pOd6AFuGOS/OAoB3nk+KmZacd1S7lON3fN
         EAQPuLYuKVsNHvdYvZpk7pAqv3NKh6po23T6w9rIwewSl/RZIr/3XL5FApiSMECSa8sY
         iyy8l+V5LncBqTFLEV+nqK9AXx18DyswFgs8uk74Lfd1DE5OIY5Fad9fKy08j2HzA5zm
         deFaq6TkfCP5fLEDeScU/qCVPd3vnkGteqKY1Bd7bAtNP5hbCioB1gIbHVbMyOtT7tnj
         O7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30mLK80vSZcSwBOrdpYOKvqdrdKJjCkQDSG3S0CWQyQ=;
        b=xkd5jhSAyssdV6m9Vs+SdE+Qusi/Ck3praPZo2lVr+CGvvODHHj1DsvBqYe2Rstxce
         PaO/AaWkdKsMdfDcbpi86tLqrSAquJfgLCYoKOp5FcRUP1ELxWhyog8fBGsU1T5GxWxu
         dkzByxik/+rTb+MhC/jHq+5K3LvWT2Qx8jtNVyqLDahya3Q2H651maTtsM6Pj6Up8pdm
         5LSGc4fAA7gBCzrAkHo3gu3wgnb8OKGfIkifi3h4nhUxyouoy6dzaK2MuZSqSohtZVdu
         QtC7MNYxvuUXU3RmYCNjWAeA7St3eKiUjDjRuC1S7F+4bzqEIXh4nmYboeIzEAzTrfkr
         ZwLA==
X-Gm-Message-State: AO0yUKWnrM63y0JpXjQaF8VzBL6BZpnyvPmlYetflb62wacKlG7GzeZF
        eNdAGLXo03Km3WXxzhSGB5UNO0C7I8mxStoPDrE=
X-Google-Smtp-Source: AK7set/dRf0WU11GkPtBHZ6QIFDTOgfZiqMjAsnKwetGWUD5fMCri0hKKifEK392yPZVuNMu/VOQLPexDQdmOG9kGCY=
X-Received: by 2002:a17:906:680f:b0:883:b1d3:ae67 with SMTP id
 k15-20020a170906680f00b00883b1d3ae67mr1422704ejr.5.1676682742356; Fri, 17 Feb
 2023 17:12:22 -0800 (PST)
MIME-Version: 1.0
Sender: akondotafa240@gmail.com
Received: by 2002:a05:7208:8799:b0:62:8acd:8a88 with HTTP; Fri, 17 Feb 2023
 17:12:21 -0800 (PST)
From:   Miss Katie <Katiehiggins302@gmail.com>
Date:   Sat, 18 Feb 2023 01:12:21 +0000
X-Google-Sender-Auth: kguzpX-X5iw1K_AcX46mQh1GhuE
Message-ID: <CAM5Ze1szktnfmGCBTOZPr4-fjkbZHonw1MLTuGNL_PpqvwG3kA@mail.gmail.com>
Subject: RE: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hallo,

Sie haben meine vorherige Nachricht erhalten? Ich habe Sie schon
einmal kontaktiert, aber die Nachricht ist fehlgeschlagen, also habe
ich beschlossen, noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob
Sie dies erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Fr=C3=A4ulein Katie
