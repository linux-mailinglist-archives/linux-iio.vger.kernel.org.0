Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DABE7CC336
	for <lists+linux-iio@lfdr.de>; Tue, 17 Oct 2023 14:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjJQMb7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 08:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjJQMb7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 08:31:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B10A4
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 05:31:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so220709166b.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697545916; x=1698150716; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cx0veqHwzHp5A3VDdWtyaLxkT7+VqHGWreRswTlHnAc=;
        b=kcp9R2RKIxGzI5EP1YqRwNV5w7IJIzWVMlnuzydPATaom3mAV9QcWmHRbVVMC59ZqY
         TRyP+IjH0fVeT9V4hqeUG/YPbQJFk/vzFvib0I63P9FiZYYZpgMKv8tLoLf7comdJU+I
         aooYckgCKLoMtGNf7CZHQU3uBq1gmc0iudLc5UyuU7pOe1PkP5zhEd47bi7Cnn7cHIJL
         elEHdoyVDwXse44lUPZ9tLlUTiHihjjI1CNr7ITu3eOzMntWCfwosQUKqHxlUnz0g2bs
         PupvNXfCJGIERPE8ZK6uPQEFHb328Q7xvfrnKIwCUMfRXOjuuJ5QZ1AVq2Y3JFRuePOA
         S5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697545916; x=1698150716;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cx0veqHwzHp5A3VDdWtyaLxkT7+VqHGWreRswTlHnAc=;
        b=YReWVohu+TTU9NRAbYetXKlf+q3QMxubwp8rTm63i3RyjkRh9K6cZbtInaTru+Fcnx
         J24cL3XLfli+CRDfBPWfbhewe73lqYuAY1GqTFzVABoUydwjR4sRxNQycGwpYpqLY07k
         hMUJ99PNw3KFiz5kekN72kme2uNm4JoXYKF0ofHHHlOSbUDw/vYZI13Q+vSZvnqf/vDN
         nvgGmtragFvldDCCRvn4rdDp7eGmDic8wxv+fql4ySc2ufv8GKoD5WpA/BLCbxf2RJlq
         x5QaJK1qcHQhZbYuAV3H3Ixc3px9f55224B4MJNGhMfQjNxHJC9ZmiN5gHB+57UDkCB/
         bfQA==
X-Gm-Message-State: AOJu0YwnFM6j7xkOKSXJDKVLLz0244D5KtBw5Kh63nWa7giKByFzd2yK
        mQx69KNntSEYpamcLv7yd1ooMK4fWJMemW4kSaw=
X-Google-Smtp-Source: AGHT+IEmkxw/HJrb48A7VSlV5L3w0vILmcJ95ZlTeQghtaemHPwtHWko/pLogZi1BHvnB9sRPajydkVw8BHBVUF2X78=
X-Received: by 2002:a17:907:60d0:b0:9be:d55a:81c3 with SMTP id
 hv16-20020a17090760d000b009bed55a81c3mr1533370ejc.67.1697545916196; Tue, 17
 Oct 2023 05:31:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:6eac:b0:9b2:73cc:5dd6 with HTTP; Tue, 17 Oct 2023
 05:31:55 -0700 (PDT)
From:   Adamjee Enterprises <drronantynan@gmail.com>
Date:   Tue, 17 Oct 2023 13:31:55 +0100
Message-ID: <CAPjCx2E761=oYcS5SYExs89A+PMBGAPz9x3Ha0gG_VCohDzQ3w@mail.gmail.com>
Subject: Purchase Order
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Greetings,

We want to buy your products. Can you send us your price / order list?

Kindly reply.
Regards
