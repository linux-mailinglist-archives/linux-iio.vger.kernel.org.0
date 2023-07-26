Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3143764253
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jul 2023 01:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGZXFj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jul 2023 19:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGZXFh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jul 2023 19:05:37 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309071737
        for <linux-iio@vger.kernel.org>; Wed, 26 Jul 2023 16:05:36 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7836272f36eso12762939f.1
        for <linux-iio@vger.kernel.org>; Wed, 26 Jul 2023 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorado.edu; s=google; t=1690412735; x=1691017535;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR21IqnAZNvaOjpzBUrSW7AGTTngouD75cSb2erZPIU=;
        b=Iouyl0A4+E+B9oQWsKTUnF42oChjfoSpKTUbyrwacgczIZpp50hDhhZv/7jy+M6BiB
         CjfU27lAb2KE3Vm/xCNytWzQ6MuCb2yH7fXWMgoxjPD7wfxzxNIgf3rhm1rdRkISE2tS
         5PeUnE+l52ZCG6/E4CK8JoJ1eSGaFpD8E3oz4c2RhpmtYFptrxYCIqCFwnYrM3xzuzlW
         NXVvGwijmIFhXIuYVDgx79DD+HpVrIyCAhicvxQ40ws2Or5mMhOPFnUZq0NcrFo3Oc5X
         je1p7uKIImOWlzKmqqf5wnq5tOSL7bI59oPg5RdRLng62Dp2/j2T9GTr9Cu/qYSOhCjY
         cTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690412735; x=1691017535;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zR21IqnAZNvaOjpzBUrSW7AGTTngouD75cSb2erZPIU=;
        b=HFC8/7z/RRkfPu7Vz0hnkC5J/SPP1lumLUq0MBHKa9v40t+4BkUOyRVpxFFFy25N4L
         1N21qn3Q5unsc9G08QmRzQi2HWWSVZ0meEsMlNNQbhZNkSX7qPI4/LrzFxWZ0TERs/zd
         /SgZBghFSfez3h3/srUosywqS1UIllyEdkqShZsNYUED0x81hCByRCvfpO7Ay4SB48Ru
         nFWWze9PlyxZrdQCfQ0GbKfN/HFkjiS4xSPOcsxUAXcqR6sse4GwPJGrRqobYoWrWszR
         dD+9qJJthiy/dVJATgEVR9wverXEFrZoKvpTCvj1jFbc8CWgQXqGiDB13EjfUyZrh9Up
         RXIg==
X-Gm-Message-State: ABy/qLaci8cG0M/wPA8nfHdnE8RASz6p08X3Li0/XtmEeFqUczKivNeo
        B1oF/7sK13kxSvvOHpUhxX4v1WkZf+ox2yBta8iQOmBsvXBG/d/E
X-Google-Smtp-Source: APBJJlGznj7dXTjCaUr+Z9wWPXZOv0l3g8UWCSHt4gUyN1K2RKCuBS8e9htG92CwfYYzuJGIcp0IVp75MV4c9jJCY+E=
X-Received: by 2002:a05:6e02:dc5:b0:348:ec07:9dfa with SMTP id
 l5-20020a056e020dc500b00348ec079dfamr2979379ilj.14.1690412735188; Wed, 26 Jul
 2023 16:05:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:b855:0:b0:2da:b9a4:a502 with HTTP; Wed, 26 Jul 2023
 16:05:34 -0700 (PDT)
Reply-To: isch4196@colorado.edu
From:   isch <isch4196@colorado.edu>
Date:   Wed, 26 Jul 2023 16:05:34 -0700
Message-ID: <CAH6EE1HB=hK5epTpJ6skUHsRuf+0zVQ3ZooOO7rRV0PWH2Kb-Q@mail.gmail.com>
Subject: Trouble updating the current_trigger
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all, hopefully this is the right place to post this.
I'm having some trouble with configuring a sysfs trigger for the
mpu6050. I am running this on a raspberrypi 3b on yocto kirkstone. The
problem is whenever I try to write to the current_trigger file, I get
this error: "sh: write error: Invalid argument". Here are the steps I
take:

cd /sys/bus/iio/devices/iio_sysfs_trigger
echo 0 > add_trigger
cd /sys/bus/iio/devices/trigger1 #trigger0 exists by default, so it
creates trigger1
cat name #gives sysfstrig0, as expected
cd /sys/bus/iio/devices/iio:device0
echo sysfstrig0 > trigger/current_trigger #results in "sh: write
error: Invalid argument"

A couple of observations. Writing the default trigger, "mpu6050-dev0"
to the file works. Anything else besides "mpu6050-dev0" and
"sysfstrig0" doesn't result in any error, but the contents of the file
is blank. Since, writing "sysfstrig0" to it results in an error, it
must mean that it is registered to the iio subsystem, but that
something else is perhaps configured wrongly?

This is my first time using IIO, so happy to get any pointers on how
to debug this.
Thank you in advance.

- isch
