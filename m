Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2165F7E3
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jan 2023 00:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjAEXuj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Jan 2023 18:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjAEXui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2023 18:50:38 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A9A34D5E
        for <linux-iio@vger.kernel.org>; Thu,  5 Jan 2023 15:50:38 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id k137so21738015pfd.8
        for <linux-iio@vger.kernel.org>; Thu, 05 Jan 2023 15:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dUGG4xNbmHxqZEWk1QIkj1J4BmjM8dGcX1VYzdsWsY=;
        b=AkF8e5fzAZ2VeUWgeccokzgmGMkI/xbhVuZWko5E+WUCvTbBhrEKmFzqLouhvH+mff
         qSqo5/ZV3earTqKSCp3SucQw6ZEGAkuyiK3Va6Q3oXWSho1ztU5OiVZ3KGLnymu6SJyF
         yJYorrv3G2fCSumBtEidADBhZh5crz739IbFEP5+7NCyC5U+LgwrtBXkkrYFbt2jOXWq
         Y449etWueBSN1zELXIYwdt5uyRHikVqeb51i58uQwmdHeqEo3o44FSBxNW34TTRgo/m9
         jJH9mwbhak1aC6v/2dJ4HHsUFY3j5uoPORWHh05YdVfKLqkVjjUuMV7nkiWOtRDGTt9L
         MeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dUGG4xNbmHxqZEWk1QIkj1J4BmjM8dGcX1VYzdsWsY=;
        b=aXMM76nIRKp0BzTAe2JX9m8yw0abD4yMepGa+UDW7+B7abOPlti0rl+EPMWxbfkYwh
         UkM8Z2MAI+94cjU0s/N7WhW0kL577SqByU3EIFVae5dV6ALZDnOJFzyw9Ni3V9FV0MuK
         wXc1lEyDFgi1X2p63dGaKjI3PdGd9bB81VUo0LDn15wnriACFOyPgmJBNQEtZMBVVImt
         jILAPe127nDcRgBc7Fx45AJPGyx354a+GNI4oAIqTYQ3qw0HzG4dC62P+JGFrP60L41V
         X5/3PE6T75OdBgQrHkqUJ1+ziJ63fhWyH2h++Jw9PW3BNwj+JUiX783n37TOGbLNNMgL
         uW+Q==
X-Gm-Message-State: AFqh2kqz792amCJ2ODk6evQp6UwSkXHmI+T0w4N+L8+8xfyyQkvfdk+e
        ZOMyXV2JWHnRVNDNVvWeWIWFxwDByX1ZA29P//uz4if2TK3dPfADOwkxMw==
X-Google-Smtp-Source: AMrXdXvnfYaDhVS8foEMYOEQlITVPNRz/fxf/qtKT1wYa+88dUuBCAVEBsDcBAahaCKU6vtleoo7q7KppsH16zgzEeY=
X-Received: by 2002:a05:6602:110:b0:6e9:a169:c879 with SMTP id
 s16-20020a056602011000b006e9a169c879mr3296848iot.99.1672962309821; Thu, 05
 Jan 2023 15:45:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a92:c147:0:b0:304:bdf2:e728 with HTTP; Thu, 5 Jan 2023
 15:45:09 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <mcaitlin9999@gmail.com>
Date:   Fri, 6 Jan 2023 00:45:09 +0100
Message-ID: <CAPfBHRZD4pVvik6GendF69T3qA4ykoMKDEioXBhGmcT6ACQgxw@mail.gmail.com>
Subject: From Dr Ava Smith in United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Hello Dear,
My name is Dr Ava Smith.Am an English and French nationalities.
I will be waiting to get a response from you so i can tell you more
about my self and share so some photos too.
Thanks
Ava
