Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DDC4B1CF9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Feb 2022 04:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiBKDeM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Feb 2022 22:34:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiBKDeM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Feb 2022 22:34:12 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A59155AF
        for <linux-iio@vger.kernel.org>; Thu, 10 Feb 2022 19:34:12 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id fy20so19827352ejc.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Feb 2022 19:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Me2pGNOEJUAhTIZfjxQlWnCMZq/HTXhR17XSZzd+Ok4=;
        b=XLUWGIl7UJnr1o5Jwh/LkYa+DWvLTZoZwVYhF7G55z1Ji2QRP9cQrutA2L4hN2hhO6
         OxyJ5Ii7iaDETQZiuPksg2kDnzJXb2ATGXPaUe1IvSeU1uyPtXTJ0PtiZ0ursoeOnczO
         Xrqq6usq3L89o5zwTMfrEQ/OaIcit9sO8vENLIwAgIkhmRVGbVRCxypTveLrixx7rKNh
         0KCrEKb/49bPL248EYnAvuPmp8x8e6NIXlslfRFrUev6kRl96jtxQrNrEhNAMkjEalEM
         jaj7LhMqvSQNtptyaL+3XKglCb5lOAWxKqXYg5s9f+bV+hN1+brufLhaW7bqUi7jNiGJ
         sDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Me2pGNOEJUAhTIZfjxQlWnCMZq/HTXhR17XSZzd+Ok4=;
        b=iCeRx4TERQBYT4trrZi8DWZ3eOp+jy4YfUwKRMErE7xGlw+e+aTnskWlZKCwW5vCYc
         zljhkDSI0TQDcuhII8irVB4Kx6r9JKWvgeiJTPOGzV3Dgd4mi2mGTIvJwDFGOqHMwmeO
         0cKGmDkqR5MwVAEU+yF9pPuaObrB/wu8+4TLcIbZ9MtNGW5pwYpv7SDr8/jdZBsjJTxm
         70HmuijEyRxA5Rd2UWmLduVAK1jzHReAQSwLAcYCjs82XG7RSSc4fAwgb3dNGJyhc0yH
         V2B1VAojdbNZ5p8B+D/B6SsaK3UF5IDJqtyKsjjjqKYXJMLQ+8aIfu6NXubFQzNIMbFd
         dk5g==
X-Gm-Message-State: AOAM531/KDtRM71UXXXXMPmgGsnnYsaxBSy05sVszraL/U1oDZOGTOnG
        THblbXycdAK1ECypBEFK7opLM7BUmA2hl8XCLpY=
X-Google-Smtp-Source: ABdhPJzHOSV+EmUtrLoUgFFJNfk+HSgnfWfMCprZrGHseusaFLJ5PMArj4UOJI8zJmuu5nJrE0pAEiKTl8G7Js35qbo=
X-Received: by 2002:a17:906:d555:: with SMTP id cr21mr9500814ejc.458.1644550450994;
 Thu, 10 Feb 2022 19:34:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:8693:b0:6ca:f91:3c48 with HTTP; Thu, 10 Feb 2022
 19:34:10 -0800 (PST)
Reply-To: tamblynbarr47@gmail.com
From:   Mr Bello <frankoleka77@gmail.com>
Date:   Thu, 10 Feb 2022 19:34:10 -0800
Message-ID: <CAHQPQhBzGGyyckREc0=Q5VcQiUVJJiiRRHo_T1J7vxcFb+npuA@mail.gmail.com>
Subject: Are You Still Using This Email Address?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,


I have sent you two emails and you did not respond, I even sent
another message a few days ago with more details still no response
from you. Please are you still using this email address? I am VERY
SORRY if sincerely you did not receive those emails, I will resend it
now as soon as you confirm you never received them.



Regards,

Bello.
