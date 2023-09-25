Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F597ADB23
	for <lists+linux-iio@lfdr.de>; Mon, 25 Sep 2023 17:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjIYPOs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Sep 2023 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjIYPOj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Sep 2023 11:14:39 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0059F10C
        for <linux-iio@vger.kernel.org>; Mon, 25 Sep 2023 08:14:32 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id a1e0cc1a2514c-7abda795363so485744241.0
        for <linux-iio@vger.kernel.org>; Mon, 25 Sep 2023 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happybizdata-com.20230601.gappssmtp.com; s=20230601; t=1695654872; x=1696259672; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BtNfrxgf4X+cTsDMONzKl75qRElkb7tAwQe0Ph+Ar2Q=;
        b=sYFFVxTO7mmkMpPpxZEPfnlzlM/T/6xEB9VPDAjLiV2jBk0QcpLeNI0VOJxLgsZkCW
         8eDpVfuMcHKbfJp9JcDrM0GuFAAq0QqsfLO0lwgkjOJ922oaiT2ssTKDH1td1JoGb9sm
         5h34ZLANxhPTQc5vjCTURf98MemtS6Ed+2XtyNjclNEaaHlSpKfV9WfFBUuXhphiwdqv
         X3tzwOriQUOGlT7IqG7qxPswJuxlyBt2QdsNE6GKMMqkK1O4rJANdkg8yS7GYvcQfMIY
         p8m7vgSJf66pqIm2U6bAONWCbSNA/mhO/PgcTOdhiaLNBD4rhnbAhkSH3lPyJuUdUY2m
         D6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654872; x=1696259672;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtNfrxgf4X+cTsDMONzKl75qRElkb7tAwQe0Ph+Ar2Q=;
        b=pexF4HO7n/UVgxaSjDYmT5JqVaWPXwyB7sYt23v+oH20LJIZNXmZCWKndBQd3qYvJA
         or890XA3VHjPNtgYuRs1Go47YtIK11cmhHzRj2LlrsZx4EEDwmbyfiG/HjqGIh8yeIVl
         dvS6eRgAscFsUayEGHpF6P9bugNc0i+RfmPa3KOg2ByeceUpNJuwvXwQ2THK1Fn1lztx
         1ULLfvTEkiFaWtmHHdVZvbLBHSC7clFq0WzAOyWxQQZW/BVOAOPzl3iQ3dIJo/+RRGC1
         mJEFd2mAzc9uP3xVq1xbWC2YgbeTyqCntR0oVL+WFgzUOyvjedq35r2m6ZrMdD7YbiKb
         ENRQ==
X-Gm-Message-State: AOJu0YwLsMtKZ9l5eQ6Ynm7ux/gO3b55+Lf1SomdSCWYQHsEez1vc1DT
        RZC3i8wbPKrHXgcaWej+kNTtS6v6QhfoqNCiLnocEg==
X-Google-Smtp-Source: AGHT+IGXoI5YnmpGzarbNHUN6kc7WhvoSLsKXh0wGe4yMYAk1E/+nnoqiizAAorg1SHUkHOlncRxdvgxo5nvLpAT5tU=
X-Received: by 2002:a05:6102:34c3:b0:452:8ad4:29d9 with SMTP id
 a3-20020a05610234c300b004528ad429d9mr4212916vst.17.1695654872104; Mon, 25 Sep
 2023 08:14:32 -0700 (PDT)
MIME-Version: 1.0
From:   Sofia Gonzales <sofia@happybizdata.com>
Date:   Mon, 25 Sep 2023 10:14:15 -0500
Message-ID: <CAMh3ZMKYnXqAKMHMafqrwYMvNF+vD+Y6GrDNJinYQnAm=e3_Gw@mail.gmail.com>
Subject: RE: HIMSS Global Health Conference Email List 2023
To:     Sofia Gonzales <sofia@happybizdata.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Would you be interested in acquiring the Healthcare Information and
Management Systems Society Email List?

Number of Contacts: 45,486
Cost: $1,918

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Sofia Gonzales
Marketing Coordinator
