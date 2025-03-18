Return-Path: <linux-iio+bounces-17020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F280DA67338
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 12:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA0319A1F0D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18C620A5DC;
	Tue, 18 Mar 2025 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJDPsS25"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E13FC2
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298974; cv=none; b=YcumpNwWJD7rZLD2NHXMQp+SqBHxg/1TqH4HcZWjHuNmY2Z50d6aTwu5esKCn+p2mEA+1pUj+OeVlBOcAViic8/WvXjKTUjl2C4KSE/L+SbnN8zQmupdqhYex0f0Z81pQTn1/VJp5Sz6WlC+ERVkZ6RTkGtgc+WpnzspGN7+IAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298974; c=relaxed/simple;
	bh=YQ0iSzo3j5JwlxZF0g+jqp7dqDegBpLdljQBLnVbt/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nktoU/IMX2zqOnT8ip+Grnq/aiDhd91zYIjm7CoeqpUvxvmU1cepDGQtG4/MENnVzRvhcI4JqiTNzWWC9fR+hv+fp395C3zZP1b69Kb6KMdxGOhzz7nUwsCzBZ76x+DlCZ5CPOFw23oCLWRIOCNOuba32N73ce9K9wus7OqF6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJDPsS25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52BA1C4CEDD
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298974;
	bh=YQ0iSzo3j5JwlxZF0g+jqp7dqDegBpLdljQBLnVbt/4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BJDPsS252pO9sOsiFOJqYx+46e27dJb1PT3mmT01f3sqWpdJS+onXiFgV6DBzh6fF
	 ZnIo92fQ/DpIIiVHa0VuPCgmYhT84E5yH3bSAZ6J7ZAJj3trYOoctw9oxmTawMD6Bg
	 iU+i95eiPyIq7tZeYCgGGxOp/dc2ncuttsRl0hQqynu0kdKD+q4qLRFOdPmMIygCG7
	 zOmTko0pf3u7pXRJ5lyfSc4kdnPgJXNK8QgsOa9lfvyEUE5SyAVR0UDgYPGOO5/Vph
	 afYqCM320fqH6CtkZCnWRYoGmWr4m8JSZ//4IpHxLM90Uvwgvw9DuMCwur7KVmphIy
	 a+FQxfvkPBJ5w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6DA41C3279F; Tue, 18 Mar 2025 11:56:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Tue, 18 Mar 2025 11:56:07 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wysiwyg81@rbox.co
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219890-217253-765SESCpL2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219890-217253@https.bugzilla.kernel.org/>
References: <bug-219890-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219890

--- Comment #8 from Fred (wysiwyg81@rbox.co) ---
Created attachment 307849
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307849&action=3Dedit
logs from iio_generic_buffer

This are the logs from sudo ./iio_generic_buffer -n als -a -c 1000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

